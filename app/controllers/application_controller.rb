# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound,       with: :not_found
  rescue_from ActiveRecord::RecordInvalid,        with: :record_invalid
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  before_action :authenticate_user!

  private

  def not_found(error)
    render status: :not_found,
           json: { message: I18n.t('api.errors.not_found',
                                   model: error.exception.model) }
  end

  def record_invalid(error)
    render json: { message: error.message }, status: :unprocessable_entity
  end

  def parameter_missing
    message = I18n.t('api.errors.parameter_missing')
    render json: { message: }, status: :bad_request
  end
end
