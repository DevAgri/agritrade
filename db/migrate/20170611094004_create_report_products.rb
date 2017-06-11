class CreateReportProducts < ActiveRecord::Migration
  def change
    create_table :report_products do |t|
      t.references :report, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.decimal :unit_value, precision: 8, scale: 2
      t.decimal :quantity, precision: 8, scale: 2
    end
  end
end
