class CreateProductAttributes < ActiveRecord::Migration
  def change
    create_table :product_attributes do |t|
      t.references :product, index: true, foreign_key: true
      t.references :attribute, index: true, foreign_key: true
      t.string :value
    end
  end
end
