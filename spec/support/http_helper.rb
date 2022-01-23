# frozen_string_literal: true

module HttpHelper
  def parsed_body
    JSON.parse(response.body, symbolize_names: true)
  end

  def authenticate(user = create(:user))
    token = JsonWebToken.generate(user_id: user.id)
    request.headers.merge!("Authorization: #{token}")
  end
end
