class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.citext :email
      t.string :encrypted_password
      t.integer :role
      t.string :avatar_image_id
      t.string :avatar_image_filename
      t.string :avatar_image_content_type

      t.timestamps null: false
    end
  end
end
