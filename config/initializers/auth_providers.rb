# Project custom configs
PROJECT_CONFIG = YAML.load_file("#{::Rails.root}/config/the_project.yml")[::Rails.env]
# OAuth providers
TWITTER_CONFIG = YAML.load_file("#{::Rails.root}/config/twitter.yml")[::Rails.env]
FACEBOOK_CONFIG = YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]
# External Apis
BITLY_CONFIG = YAML.load_file("#{::Rails.root}/config/bitly.yml")[::Rails.env]