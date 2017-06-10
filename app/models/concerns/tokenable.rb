module Tokenable
  extend ActiveSupport::Concern
  include ActiveModel::Serialization

  def to_token(options = {})
    payload = serializable_hash options
    Token.encode payload
  end

  class_methods do
    VALID_OPTIONS_FOR_TOKEN = [:expire_at, :only_after].freeze

    OPTIONS_ALIAS_FOR_TOKEN = {
      :expire_at => :exp,
      :only_after => :nbf
    }.freeze

    def token_options
      @token_options ||= {}
    end

    def token(options = {})
      options.each_key do |key|
        unless VALID_OPTIONS_FOR_TOKEN.include? key
          raise ArgumentError, "Unknown key: #{key.inspect}. Valid keys are: #{VALID_OPTIONS_FOR_TOKEN.map(&:inspect).join(', ')}."
        end
      end
      @token_options.merge! sanitize_token_options(options)
    end

    def from_token(token)
      payload = Token.decode(token)
      return payload unless Object.const_defined?('ActiveRecord') && self < ActiveRecord::Base
      find_by sanitize_payload_columns(payload)
    end

    private

    def sanitize_token_options(options)
      sanitized_options = {}
      options.each do |key, value|
        sanitized_options[OPTIONS_ALIAS_FOR_TOKEN[key]] = value
      end
      sanitized_options
    end

    def sanitize_payload_columns(payload)
      payload.each do |key, value|
        payload.delete(key) if OPTIONS_ALIAS_FOR_TOKEN.has_value? key.to_sym
      end
    end
  end
end
