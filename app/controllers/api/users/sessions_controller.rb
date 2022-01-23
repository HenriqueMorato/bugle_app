# frozen_string_literal: true

class Api::Users::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :authenticate_user!

  def create
    user = User.find_by!(email: sign_in_params[:email])

    if user.valid_password?(sign_in_params[:password])
      @token = JsonWebToken.generate(user_id: user.id)
      render json: { token: @token }
    else
      render json: { message: I18n.t('devise.failure.invalid',
                                     authentication_keys: 'email') }
    end
  end

  private

  def sign_in_params
    params.permit(:email, :password)
  end
end
