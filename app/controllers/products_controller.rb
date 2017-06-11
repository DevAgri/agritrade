class ProductsController < ApplicationController
  before_action :set_vars, only: [:show, :reports]

  def show
  end

  def reports
    render json: @product.report
  end

  protected

  def set_vars
    @beginning_of_month = Date.today.at_beginning_of_month
    @end_of_month = Date.today.at_end_of_month
    @product ||= Product.find(params[:id] || params[:produto_id])
    attributes = @product.product_attributes.includes(:attribute_entity)
    @formulation = attributes.find_by('attributes.code': 'formulation').try(:value)
    @culture = attributes.find_by('attributes.code': 'culture').try(:value)
    @class = attributes.find_by('attributes.code': 'class').try(:value)
    @brand = attributes.find_by('attributes.code': 'brand').try(:value)
    @active_ingredient = attributes.find_by('attributes.code': 'active_ingredient').try(:value)
    @better_price = @product.better_price
    @high_price = @product.high_price
    @medium_price = @product.medium_price
    @my_price = @product.medium_price(mock_current_user)
    @related_products = @product.related_products
  end
end
