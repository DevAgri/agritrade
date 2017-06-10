class Session
  class << self
    delegate :from_token, to: :User
  end

  def initialize(user)
    @user = user
  end

  def authenticate(password)
    if @user.nil? || !@user.password? || !@user.valid_password?(password)
      false
    else
      self
    end
  end

  def to_token
    @user.to_token(only: :auth_token, exp: 10.years.from_now)
  end
  alias :access_token :to_token
end
