class ApplicationController < ActionController::Light
  rescue_from ActiveRecord::RecordInvalid,   with: :unprocessable_entity
  rescue_from ActiveRecord::RecordNotUnique, with: :unprocessable_entity

  def unprocessable_entity = head(:unprocessable_entity)
end
