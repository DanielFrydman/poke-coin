CONFIG = if Rails.env.production?
           YAML.load_file(Rails.root.join('app.yml'))[Rails.env]
         else
           YAML.load_file(Rails.root.join('config/app.yml'))[Rails.env]
         end

module APP_CONFIG
  COIN_API_KEY = CONFIG['coin_api_key']
end
