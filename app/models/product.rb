class Product < ActiveRecord::Base
  has_many :product_attributes, inverse_of: :product, dependent: :destroy

  validates :title, presence: true

  attachment :avatar_image, type: :image

  accepts_nested_attributes_for :product_attributes, allow_destroy: true
end
