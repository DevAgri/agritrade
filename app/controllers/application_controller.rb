class ApplicationController < ActionController::Base
  include Pundit

  before_action :set_locale

  def authenticate_admin_user!
    if current_user
      current_user.admin? || redirect_to(destroy_user_session_path)
    else
      redirect_to(new_user_session_path)
    end
  end

  def set_admin_time_zone
    Time.zone = Rails.application.config.time_zone
  end

  protected

  def map_nested_attributes_keys(klass, attributes = nil)
    attributes = params if attributes.nil?
    nested_keys = klass.nested_attributes_options.keys
    attributes.inject({}) do |h, (k,v)|
      if nested_keys.include?(k.to_sym)
        key = "#{k}_attributes"
        return h if !v.kind_of?(Array) && !v.kind_of?(Hash)
      else
        key = k
      end
      h[key] = v
      h
    end.with_indifferent_access
  end

  def sti_model_for(klass)
    model_name = (params[:type] || klass.name)
    model = model_name.camelize.constantize
    return klass unless model <= klass
    model
  rescue NameError, ActiveRecord::SubclassNotFound
    klass
  end

  private

  def set_locale
    I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales) || I18n.default_locale
  end
end
