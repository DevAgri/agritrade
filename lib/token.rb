class Token
  class << self
    def encode(payload)
      payload[:exp] = payload[:exp].to_i if payload[:exp]
      payload[:nbf] = payload[:nbf].to_i if payload[:nbf]
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      JWT.decode(token, Rails.application.secrets.secret_key_base).first
    end
  end
end
