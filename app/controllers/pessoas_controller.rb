class PessoasController < ApplicationController
  before_action :set_pessoa, only: %i[ show ]

  def index
    render json: Pessoa.all
  end

  def show
    render json: @pessoa
  end

  def create
    @pessoa = Pessoa.new(pessoa_params)

    if @pessoa.save
      render json: @pessoa, status: :created, location: pessoa_path(@pessoa)
    else
      render json: @pessoa.errors, status: :unprocessable_entity
    end
  end

  private
    def set_pessoa
      @pessoa = Pessoa.find(params[:id])
    end

    def pessoa_params
      params.require(:pessoa).permit(:apelido, :nome, :nascimento, stack: [])
    end
end
