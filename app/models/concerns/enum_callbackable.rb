module EnumCallbackable
  extend ActiveSupport::Concern

  included do
    def self.enum_callbackable(*names)
      names.each do |name|
        enum = name.to_s
        raise(ArgumentError, "#{self.to_s}##{enum} is not a enum.") unless defined_enums.has_key?(enum)
        callback_name = "run_callbacks_if_#{enum}_enum_changed!"
        send(:define_model_callbacks, *defined_enums[enum].keys, only: [:before, :after])
        define_method(callback_name) do |&block|
          if self.send("#{enum}_changed?")
            run_callbacks(self.send(enum).to_sym, &block)
          else
            block.call
          end
        end
        send(:around_save, callback_name.to_sym)
      end
    end
  end
end
