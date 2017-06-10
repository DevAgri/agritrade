class CreateAttributeValues < ActiveRecord::Migration
  def change
    create_table :attribute_values do |t|
      t.references :attribute, index: true, foreign_key: true
      t.string :label
    end
  end
end
