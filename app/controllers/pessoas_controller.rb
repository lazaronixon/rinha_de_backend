class PessoasController < ApplicationController
  def index
    if params.has_key?(:t)
      render json: Pessoa.search(params[:t]).limit(50)
    else
      head :bad_request
    end
  end

  def show
    pessoa = Pessoa.find_cached(params[:id]); render(json: pessoa)
  end

  def create
    pessoa = Pessoa.create_in_batch_later!(pessoa_params); head(:created, location: pessoa_path(pessoa))
  end

  def contagem_pessoas
    render plain: Pessoa.count.to_s
  end

  def pessoa_params
    params.require(:pessoa).permit(:apelido, :nome, :nascimento, stack: [])
  end
end
