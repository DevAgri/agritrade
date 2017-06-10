class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :code
      t.string :label
    end
  end
end
