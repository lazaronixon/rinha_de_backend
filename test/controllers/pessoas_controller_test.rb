require "test_helper"

class PessoasControllerTest < ActionDispatch::IntegrationTest
  test "should get contagem pessoas" do
    get contagem_pessoas_url, as: :json
    assert_response :success
  end

  test "should get index" do
    get pessoas_url, as: :json
    assert_response :success
  end

  test "should create pessoa" do
    assert_difference("Pessoa.count") do
      post pessoas_url, params: { apelido: "nixon", nome: "Lázaro Nixon", nascimento: "1988-10-06", stack: %w(ruby) }, as: :json
    end

    assert_response :created
  end

  test "should show pessoa" do
    get pessoa_url(pessoas(:one)), as: :json
    assert_response :success
  end
end
