Rails.env.on(:any) do
  config.action_dispatch.default_headers.merge! 'X-Frame-Options' => 'deny'
end
