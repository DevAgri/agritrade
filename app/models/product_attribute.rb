class ProductAttribute < ActiveRecord::Base
  belongs_to :product, inverse_of: :product_attributes
  belongs_to :attribute_entity, class_name: 'Attribute', foreign_key: :attribute_id

  with_options presence: true do
    validates :product
    validates :attribute_entity
    validates :value
  end
end
