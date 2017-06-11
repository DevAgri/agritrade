class Report < ActiveRecord::Base
  belongs_to :user

  has_many :products, class_name: 'ReportProduct', dependent: :destroy, inverse_of: :report

  validates :user, presence: true

  accepts_nested_attributes_for :products, allow_destroy: true
end
