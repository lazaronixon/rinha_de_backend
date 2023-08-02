class PessoasController < ApplicationController
  before_action :set_pessoa, only: :show

  def index
    render json: Pessoa.search(params[:t]).limit(50)
  end

  def show
    render(json: @pessoa) if stale?(@pessoa)
  end

  def contagem_pessoas
    render plain: "#{Pessoa.count}"
  end

  def create
    @pessoa = Pessoa.create!(pessoa_params); render(json: @pessoa, status: :created, location: pessoa_path(@pessoa))
  end

  private
    def set_pessoa
      @pessoa = Pessoa.find(params[:id])
    end

    def pessoa_params
      params.require(:pessoa).permit(:apelido, :nome, :nascimento, stack: [])
    end
end
