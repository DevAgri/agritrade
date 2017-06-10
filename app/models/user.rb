class User < ActiveRecord::Base
  include Tokenable
  include EnumHumanizable

  attr_accessor :from_provider

  has_many :requests

  with_options presence: true do
    with_options length: { maximum: 100 } do
      validates :first_name
      validates :last_name
    end

    validates :email, email_format: true, uniqueness: true
  end

  validates :password, confirmation: true, presence: { unless: :from_provider, on: :create }
  validates :password_confirmation, presence: { if: :password }

  enum role: [:user, :admin]

  devise :database_authenticatable

  scope :recent,            -> { order('users.created_at DESC') }
  scope :email_or_username, -> (value) { where('email = :value OR username = :value', value: value) }

  after_initialize do
    @from_provider ||= false
  end

  before_save do
    self.role ||= :user
  end

  humanized_enum :role

  attachment :avatar_image, type: :image

  def full_name
    [first_name, last_name].join(' ')
  end
end
