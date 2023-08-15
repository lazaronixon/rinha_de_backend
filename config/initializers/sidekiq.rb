if ENV["RAILS_ENV"] == "production"
  Sidekiq.logger.level = Rails.logger.level
  Sidekiq::Grouping.start!
end
