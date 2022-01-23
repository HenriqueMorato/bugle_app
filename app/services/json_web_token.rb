class JsonWebToken
  class << self
    def generate(payload, exp = 14.days.from_now.to_i)
      JWT.encode({ **payload, exp: }, jwt_secret)
    end

    private

    def jwt_secret
      @jwt_secret ||= ENV['JWT_SECRET_KEY']
    end
  end
end
