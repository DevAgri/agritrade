Rails.configuration.middleware.tap do |middleware|
  middleware.insert_before 0, Rack::Cors, debug: Rails.env.development? do
    allow do
      origins '*'
      resource '*', credentials: true,
                    headers: :any,
                    expose: ['ETag', 'Link'],
                    max_age: 0,
                    methods: [:get,
                              :post,
                              :delete,
                              :patch,
                              :put,
                              :options]
    end
  end

  middleware.use Rack::Deflater
end
