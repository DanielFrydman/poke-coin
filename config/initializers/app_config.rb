CONFIG = YAML.load_file(Rails.root.join('config/app.yml'))[Rails.env]

module APP_CONFIG
  COIN_API_KEY = CONFIG['coin_api_key']
end
