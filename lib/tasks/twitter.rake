

require 'tweetstream'

TweetStream.configure do |config|
  config.consumer_key       = 'HkShJOE3T3ZXFjZLuhV9Q'
  config.consumer_secret    = '8U0JtBuzzNT44ylIyVUbIefiqtfUeMET8jTtwqWRqE'
  config.oauth_token        = '20134211-Ne4VaeWdGnpWMKpSp3WO7GgiSwfcyc1hBl9zxI'
  config.oauth_token_secret = 'JjysuoQKe41dFUQQb5tzIxMcyBWcvimidJHyTeQrg'
  config.auth_method        = :oauth
  end

namespace :tweets do
  desc 'Looking for tweets'
  task :prueba => :environment do
    TweetStream::Client.new.track('mourinho') do |status|
      puts "#{status.text}"
    end
  end
  
  desc 'Run all lookups'
  task :all => [:prueba]
  
  task :default => :all
end

# The third argument is an optional process name
#TweetStream::Daemon.new('tracker').track('term1', 'term2') do |status|
  # do something in the background
#end


# TweetStream.configure do |config|
#   config.consumer_key       = 'HkShJOE3T3ZXFjZLuhV9Q'
#   config.consumer_secret    = '8U0JtBuzzNT44ylIyVUbIefiqtfUeMET8jTtwqWRqE'
#   config.oauth_token        = '20134211-Ne4VaeWdGnpWMKpSp3WO7GgiSwfcyc1hBl9zxI'
#   config.oauth_token_secret = 'JjysuoQKe41dFUQQb5tzIxMcyBWcvimidJHyTeQrg'
#   config.auth_method        = :oauth
#   end

  # Use 'track' to track a list of single-word keywords
  # TweetStream::Client.new.track('mourinho') do |status|
  #   @status = "#{status.text}"
  # end

  # the following to be entered in test console
# require 'rake'
# LlorensApp::Application.load_tasks # <-- MISSING LINE
# Rake::Task['my_task'].invoke

# rake feed:all
# rake RAILS_ENV=test feed:all 

# namespace :feed do

#   desc 'Feeding States'
#   task :states => :environment do
#     FastSeeder.seed_csv!(State, "states.csv", :id, :name, :cp_prefix, :covered, :requests => 0)
#   end
  
#   desc 'Feeding Cities'
#   task :cities => :environment do
#     FastSeeder.seed_csv!(City, "cities.csv", :id, :name, :state_id)
#   end
  
#   desc 'Feeding Vehicles'
#   task :vehicles => :environment do
#     FastSeeder.seed_csv!(Vehicle, "types.csv", :id, :code, :name)
#   end
  
#   desc 'Feeding Prices'
#   task :prices => :environment do
#     FastSeeder.seed_csv!(Price, "prices.csv", :id, :vehicle_id, :city_id, :price, :year)
#   end
  
#   desc 'Feeding Quote Concepts'
#   task :concepts => :environment do
#     FastSeeder.seed_csv!(QuoteConcept, "concepts.csv", :id, :symbol, :net_amount, :tax_id, :show_before, :for_car, :for_ciclo, :for_moto, :ordering)
#   end
  
#   desc 'Feeding Taxes'
#   task :taxes => :environment do
#     FastSeeder.seed_csv!(Tax, "taxes.csv", :id, :symbol, :percentage)
#   end
  
#   desc 'Run all feedings'
#   task :all => [:states, :cities, :vehicles, :prices, :concepts, :taxes]
  
#   task :default => :all
  
# end