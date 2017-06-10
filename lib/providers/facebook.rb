module Providers
  class Facebook
    include Base

    def initialize(access_token)
      super
      @adapter = Koala::Facebook::API.new @access_token
    end

    def name
      :facebook
    end

    def info!
      info
    rescue Koala::Facebook::OAuthTokenRequestError, Koala::Facebook::AuthenticationError => exception
      raise Exceptions::Provider::InvalidAccessToken.new exception, self
    rescue Koala::KoalaError => exception
      raise Exceptions::Provider::InvalidResponse.new exception, self
    rescue StandardError => exception
      raise Exceptions::Provider::InvalidCall.new exception, self
    end

    protected

    def raw_info
      {
        uid: fetch[:id],
        first_name: fetch[:first_name],
        last_name: fetch[:last_name],
        email: fetch[:email],
        avatar_url: "https://graph.facebook.com/#{fetch[:id]}/picture?width=500&height=500"
      }
    end

    private

    def fetch
      @raw_info ||= @adapter.get_object('me', fields: 'id,first_name,last_name,email').with_indifferent_access
    end
  end
end
