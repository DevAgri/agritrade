ActiveAdmin.register Attribute do
  menu priority: 2, label: -> { Attribute.model_name.human.pluralize }

  permit_params :code,
                :label,
                :value_type,
                values_attributes: [:label]

  index do
    selectable_column

    column :code
    column :label
    column(:value_type) { |item| status_tag(item.value_type) }

    actions
  end

  filter :code
  filter :label
  filter :value_type, as: :select, collection: Attribute.value_types

  form do |f|
    inputs do
      input :code
      input :label
      input :value_type, as: :select, collection: Attribute.value_types.map { |key, value| [key, key] }
    end

    inputs AttributeValue.model_name.human.pluralize do
      has_many :values, heading: false do |e|
        e.input :label
      end
    end

    actions
  end
end
