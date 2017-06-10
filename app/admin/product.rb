ActiveAdmin.register Product do
  menu priority: 2, label: -> { Product.model_name.human.pluralize }

  permit_params :title,
                :avatar_image,
                :remove_avatar_image,
                product_attributes_attributes: [:_destroy,
                                                :id,
                                                :attribute_id,
                                                :value]

  index do
    selectable_column

    column(:avatar_image) { |user| attachment_image_tag(user, :avatar_image, :fill, 50, 50) }
    column :title

    actions
  end

  filter :title

  form do |f|
    inputs do
      input :title
      input :remove_avatar_image, as: :boolean if object.avatar_image_id
      input :avatar_image, as: :file, hint: (object.avatar_image_id ? template.attachment_image_tag(object, :avatar_image, :fill, 300, 300) : nil)
    end

    inputs ProductAttribute.model_name.human.pluralize do
      has_many :product_attributes, heading: false, allow_destroy: true do |e|
        e.input :attribute_entity, as: :select, collection: Attribute.all.map { |item| [item.label, item.id] }
        e.input :value
      end
    end

    actions
  end
end
