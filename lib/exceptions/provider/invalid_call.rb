module Exceptions
  module Provider
    class InvalidCall < StandardError
      attr_reader :original_exception, :provider

      def initialize(original_exception, provider)
        @original_exception = original_exception
        @provider = provider
      end
    end
  end
end
