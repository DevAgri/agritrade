class Attribute < ActiveRecord::Base
  has_many :values, class_name: 'AttributeValue', dependent: :destroy

  with_options presence: true do
    validates :code, uniqueness: true
    validates :label
    validates :value_type
  end

  enum value_type: [:string, :options]

  accepts_nested_attributes_for :values

  before_validation do
    self.code ||= label.parameterize if label
    self.value_type ||= :string
  end
end
