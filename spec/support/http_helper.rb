# frozen_string_literal: true

module HttpHelper
  def parsed_body
    JSON.parse(response.body, symbolize_names: true)
  end
end
