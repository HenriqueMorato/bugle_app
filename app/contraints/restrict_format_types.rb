# frozen_string_literal: true

class RestrictFormatTypes
  def matches?(request)
    request.format == :json ||
      request.headers['Content-Type']&.include?('multipart/form-data')
  end
end
