class UserProvider
  def self.find_or_create_by_provider!(provider_name, access_token)
    provider = ProviderFactory.new(provider_name, access_token).instance
    attr = provider.info!
    user = User.create_with(first_name: attr[:first_name], last_name: attr[:last_name])
    user.find_or_create_by(email: attr[:email]).tap do |user|
      unless user.persisted?
        user.from_provider = true
        user.remote_avatar_image_url = attr[:avatar_url] if attr[:avatar_url] rescue nil
        user.save!
      end
    end
  end
end
