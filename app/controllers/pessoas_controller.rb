class PessoasController < ApplicationController
  def index
    render json: Pessoa.search(params[:t]).limit(50)
  end

  def show
    render json: Pessoa.find(params[:id])
  end

  def contagem_pessoas
    render plain: Pessoa.count.to_s
  end

  def create
    pessoa = Pessoa.create!(pessoa_params); head(:created, location: pessoa_path(pessoa))
  end

  private
    def pessoa_params
      params.require(:pessoa).permit(:apelido, :nome, :nascimento, stack: [])
    end
end
