module Rescuable
  extend ActiveSupport::Concern

  included do
    DEFAULT_ERROR_MESSAGE = 'Something went wrong'.freeze

    REASONS_STATUS_CODE = {
      validation: :unprocessable_entity,
      invalid_permission: :forbidden,
      invalid_credentials: :unprocessable_entity,
      invalid_authentication: :unauthorized,
      invalid_company: :forbidden,
      invalid_professional: :forbidden,
      parameter_missing: :bad_request,
      invalid_token: :bad_request,
      expired_token: :gone,
      record_not_found: :not_found,
      invalid_provider: :bad_request,
      provider_error: :service_unavailable,
      gateway_error: :service_unavailable,
      restricted_remove_record: :not_acceptable,
      already_queued: :conflict,
      invalid_cancel_order: :not_acceptable,
      invalid_cancel_completed_order: :not_acceptable,
      invalid_cancel_order_by_user: :not_acceptable,
      incomplete_profile: :forbidden
    }.freeze

    ERRORS_REASON = {
      'ActiveRecord::RecordNotFound' => :record_not_found,
      'ActiveRecord::RecordInvalid' => :validation,
      'ActiveRecord::DeleteRestrictionError' => :restricted_remove_record,
      'JWT::DecodeError' => :invalid_token,
      'Pundit::NotAuthorizedError' => :invalid_permission,
      'Exceptions::InvalidProvider' => :invalid_provider,
      'Exceptions::GatewayError' => :gateway_error,
      'Exceptions::IncompleteProfile' => :incomplete_profile,
      'Exceptions::Provider::InvalidAccessToken' => :invalid_credentials,
      'Exceptions::Provider::InvalidResponse' => :provider_error
    }.freeze

    rescue_from *ERRORS_REASON.keys do |error|
      args = {}
      args[:record] = error.record if error.respond_to? :record
      render_error ERRORS_REASON[error.to_s] || ERRORS_REASON[error.class.to_s], **args
    end
  end

  protected

  def render_error(reason = :default, status: nil, record: nil)
    body = {
      code: reason,
      message: I18n.t(reason, :default => [:default, DEFAULT_ERROR_MESSAGE], :scope => 'errors.messages')
    }
    if reason.to_sym == :validation
      raise 'Please, set the invalid record to render a validation error' if record.nil?
      body[:errors] = record.errors.map { |field, errors| { code: reason, field: field, message: errors } }
    end
    render json: body, status: (status || REASONS_STATUS_CODE[reason.to_sym] || 500)
  end
end
