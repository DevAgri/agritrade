class ReportProduct < ActiveRecord::Base
  belongs_to :report, inverse_of: :products
  belongs_to :product

  with_options presence: true do
    validates :report
    validates :product

    with_options numericality: { greater_than: 0 } do
      validates :unit_value
      validates :quantity
    end
  end
end
