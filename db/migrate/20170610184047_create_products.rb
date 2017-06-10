class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :avatar_image_id
      t.string :avatar_image_filename
      t.string :avatar_image_content_type
    end
  end
end
