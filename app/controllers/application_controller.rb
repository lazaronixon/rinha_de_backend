class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid,    with: :unprocessable_entity
  rescue_from ActiveRecord::RecordNotSaved,   with: :unprocessable_entity
  rescue_from ActiveRecord::NotNullViolation, with: :unprocessable_entity
  rescue_from ActiveRecord::RecordNotUnique,  with: :unprocessable_entity
  rescue_from ActiveRecord::ValueTooLong,     with: :unprocessable_entity

  def unprocessable_entity(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end
end
