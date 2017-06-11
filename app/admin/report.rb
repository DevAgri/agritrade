ActiveAdmin.register Report do
  menu priority: 2, label: -> { Report.model_name.human.pluralize }

  permit_params :user_id,
                :created_at,
                products_attributes: [:_destroy,
                                      :id,
                                      :product_id,
                                      :unit_value,
                                      :quantity]

  index do
    selectable_column

    column :user
    column :created_at

    actions
  end

  filter :user
  filter :created_at

  form do |f|
    inputs do
      input :user
      input :created_at
    end

    inputs ReportProduct.model_name.human.pluralize do
      has_many :products, heading: false do |e|
        e.input :product
        e.input :unit_value, as: :string
        e.input :quantity, as: :string
      end
    end

    actions
  end
end
