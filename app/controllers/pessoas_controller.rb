class PessoasController < ApplicationController
  before_action :set_pessoa, only: :show

  def index
    render json: Pessoa.search(params[:t]).limit(50)
  end

  def show
    render json: @pessoa
  end

  def contagem_pessoas
    render plain: Pessoa.count.to_s
  end

  def create
    pessoa = Pessoa.create!(pessoa_params); head(:created, location: pessoa_path(pessoa))
  end

  private
    def set_pessoa
      @pessoa = Pessoa.find_cached(params[:id])
    end

    def pessoa_params
      params.require(:pessoa).permit(:apelido, :nome, :nascimento, stack: [])
    end
end
