TWITTER_CONFIG = YAML.load_file("#{::Rails.root}/config/twitter.yml")[::Rails.env]
FACEBOOK_CONFIG = YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]
BITLY_CONFIG = YAML.load_file("#{::Rails.root}/config/bitly.yml")[::Rails.env]