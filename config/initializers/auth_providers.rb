# Project custom configs
PROJECT_CONFIG = YAML.load_file("#{::Rails.root}/config/custom/the_project.yml")[::Rails.env]
# OAuth providers
TWITTER_CONFIG = YAML.load_file("#{::Rails.root}/config/custom/twitter.yml")[::Rails.env]
FACEBOOK_CONFIG = YAML.load_file("#{::Rails.root}/config/custom/facebook.yml")[::Rails.env]
# External Apis
BITLY_CONFIG = YAML.load_file("#{::Rails.root}/config/custom/bitly.yml")[::Rails.env]