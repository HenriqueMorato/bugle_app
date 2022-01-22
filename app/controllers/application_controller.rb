# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound,       with: :not_found
  rescue_from ActiveRecord::RecordInvalid,        with: :record_invalid
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  private

  def not_found(error)
    render json: { message: error.message }, status: :not_found
  end

  def record_invalid(error)
    render json: { message: error.message }, status: :unprocessable_entity
  end

  def parameter_missing(error)
    message = I18n.t('api.errors.parameter_missing')
    render json: { message: message }, status: :bad_request
  end
end
