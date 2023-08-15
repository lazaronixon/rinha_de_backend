class PessoasCreatorJob
  include Sidekiq::Worker

  sidekiq_options queue: :default, retry: 0, batch_flush_interval: 15

  def perform(pessoa_cache_keys)
    pessoas = Rails.cache.read_multi(*pessoa_cache_keys)
    pessoas = pessoas.values

    Pessoa.insert_all! pessoas.map(&:attributes)
  end
end
