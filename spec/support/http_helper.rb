# frozen_string_literal: true

module HttpHelper
  def parsed_body
    JSON.parse(response.body, symbolize_names: true)
  end

  def authenticate_header(user = create(:user), exp = 1.day.from_now)
    token = JsonWebToken.generate({ user_id: user.id }, exp.to_i)
    { Authorization: token }
  end
end
