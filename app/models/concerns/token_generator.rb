module TokenGenerator
  extend ActiveSupport::Concern

  class_methods do
    def unique_token_generator_for(column, options = {}, &block)
      define_method "generate_unique_#{column}" do
        generate_unique_token_for column, options, &block
      end
    end
  end

  protected

  def generate_unique_token_for(column, opts = {})
    options = {length: 5}.with_indifferent_access
    options.merge! opts unless opts.empty?
    begin
      unique_token = SecureRandom.hex(options[:length])
      write_attribute(column, unique_token)
    end while self.class.exists?(column => unique_token)
    self
  end
end
