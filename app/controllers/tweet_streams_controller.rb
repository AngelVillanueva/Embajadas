class TweetStreamsController < ApplicationController
  def stream
    @greeting = "Hello"

  require 'tweetstream'

  TweetStream.configure do |config|
  config.consumer_key       = 'HkShJOE3T3ZXFjZLuhV9Q'
  config.consumer_secret    = '8U0JtBuzzNT44ylIyVUbIefiqtfUeMET8jTtwqWRqE'
  config.oauth_token        = '20134211-Ne4VaeWdGnpWMKpSp3WO7GgiSwfcyc1hBl9zxI'
  config.oauth_token_secret = 'JjysuoQKe41dFUQQb5tzIxMcyBWcvimidJHyTeQrg'
  config.auth_method        = :oauth
  end

  # Use 'track' to track a list of single-word keywords
  TweetStream::Client.new.track('mourinho') do |status|
    @status = "#{status.text}"
  end

    @farewell = "Gut Bye"

  end
end