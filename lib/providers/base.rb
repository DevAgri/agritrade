module Providers
  module Base
    def initialize(access_token)
      @access_token = access_token
    end

    def name
      :name
    end

    def name?(suspect)
      suspect.to_sym == name
    end

    def info
      cleaner(raw_info)
    end

    def info!
      info
    rescue StandardError => exception
      raise Exceptions::Provider::InvalidCall.new exception, self
    end

    protected

    def raw_info
      {}
    end

    private

    def cleaner(raw)
      ActionController::Parameters.new(raw).permit [:uid, :first_name, :last_name, :email, :avatar_url]
    end
  end
end
