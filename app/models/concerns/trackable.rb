module Trackable
  extend ActiveSupport::Concern
  include PublicActivity::Model

  included do
    tracked owner: owner,
            ip_address: ip_address,
            browser: browser,
            platform: platform
  end

  class_methods do
    private
      def owner
        Proc.new { |controller| controller.instance_variable_get(:@current_user) }
      end

      def ip_address
        Proc.new { |controller| controller.try(:request).try(:remote_ip) }
      end

      def browser
        Proc.new { |controller| controller ? "#{controller.send(:browser).name} #{controller.send(:browser).version}" : nil }
      end

      def platform
        Proc.new { |controller| controller.try(:send, :browser).try(:platform) }
      end
  end
end
