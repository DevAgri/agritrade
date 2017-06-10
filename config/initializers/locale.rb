Rails.env.on(:any) do
  config.i18n.available_locales = [:'pt-BR']
  config.i18n.default_locale = 'pt-BR'
  config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml').to_s]
end
