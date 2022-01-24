# frozen_string_literal: true

class Devise::Strategies::Jwt < Devise::Strategies::Base
  def valid?
    request.headers['Authorization'].present?
  end

  def authenticate!
    token   = request.headers.fetch('Authorization', '')
    payload = JsonWebToken.decode(token)
    success! User.find(payload['user_id'])
  rescue ::JWT::ExpiredSignature, ::JWT::VerificationError, ::JWT::DecodeError
    fail!
  end
end

Warden::Strategies.add(:jwt, Devise::Strategies::Jwt)
