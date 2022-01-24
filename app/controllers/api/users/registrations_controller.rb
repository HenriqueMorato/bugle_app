# frozen_string_literal: true

class Api::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.new(sign_up_params)
    user.save
    if user.persisted?
      @token = JsonWebToken.generate(user_id: user.id)
      render json: { token: @token }, status: :created
    else
      render json: user.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :name)
  end
end
