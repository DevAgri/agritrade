class ProviderFactory
  attr_reader :instance

  def initialize(provider_name, access_token)
    @instance = "Providers::#{ provider_name.to_s.camelize }".constantize.new(access_token)
  rescue NameError
    raise Exceptions::InvalidProvider
  end
end
