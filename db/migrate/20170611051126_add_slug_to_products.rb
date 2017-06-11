class AddSlugToProducts < ActiveRecord::Migration
  def change
    add_column :products, :slug, :string
    add_index :products, :slug, unique: true
  end
end
