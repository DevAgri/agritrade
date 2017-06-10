ActiveAdmin.register User do
  menu priority: 2, label: -> { User.model_name.human.pluralize }

  permit_params :first_name,
                :last_name,
                :email,
                :role,
                :avatar_image,
                :remove_avatar_image,
                :password,
                :password_confirmation

  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
      end
      super
    end
  end

  index do
    selectable_column

    column(:avatar_image) { |user| attachment_image_tag(user, :avatar_image, :fill, 50, 50) }
    column :first_name
    column :last_name
    column :email
    column(:role)         { |user| status_tag(user.humanized_role, (user.admin? ? :yes : :no)) }
    column :created_at

    actions
  end

  filter :first_name
  filter :last_name
  filter :email, as: :string
  filter :role, as: :select, collection: User.roles.map { |key, value| [User.humanized_role(key), value] }
  filter :created_at

  form do |f|
    inputs do
      input :first_name
      input :last_name
      input :email
      input :password
      input :password_confirmation
      input :role, as: :select, collection: User.roles.map { |key, value| [User.humanized_role(key), key] }
      input :remove_avatar_image, as: :boolean if object.avatar_image_id
      input :avatar_image, as: :file, hint: template.attachment_image_tag(object, :avatar_image, :fill, 300, 300)
    end

    actions
  end
end
