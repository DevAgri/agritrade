Rails.env.on(:production) do
  config.serve_static_assets = true
  config.action_controller.asset_host = ENV['ASSET_HOST']
  config.assets.js_compressor = nil
end
