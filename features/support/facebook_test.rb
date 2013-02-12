module FacebookSteps
  def create_Facebook(name, permissions, app_id = FACEBOOK_CONFIG['app_id'], token = FACEBOOK_CONFIG['access_token'])
    require 'open-uri'
    uri = "https://graph.facebook.com/#{app_id}/accounts/test-users?installed=true&name=#{name}&locale=en_US&permissions=#{permissions}&method=post&access_token=#{token}"
    url = URI.parse(URI.encode(uri.strip))
    response = open(url)
    code = JSON.parse(response.string)
  end
end

World(FacebookSteps)