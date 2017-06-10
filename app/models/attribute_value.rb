class AttributeValue < ActiveRecord::Base
  belongs_to :parent, class_name: 'Attribute'

  validates :label, presence: true
end
