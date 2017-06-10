class AddValueTypeToAttributes < ActiveRecord::Migration
  def change
    add_column :attributes, :value_type, :integer
  end
end
