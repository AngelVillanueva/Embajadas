Given /^I am an Ambassador$/ do
  step "an Embassy has available Missions"
  ambassador = FactoryGirl.create(:ambassador)
  ambassador.embassies << Embassy.first
end

Given /^I am a logged Ambassador through (.*?)$/ do |provider|
  step "I am an Ambassador"
  @current_ambassador = Ambassador.last
  log_in
  visit "/ambassadors/auth/#{provider.downcase}"
end

Then /^the Ambassador should persist in the database$/ do
  Ambassador.last.name.should == "facebookman"
end

Then /^her auth Token should be stored$/ do
  Ambassador.last.oauth_token.should == "456"
end


private

def log_in
  if Capybara.current_driver == :webkit
    page.driver.browser.set_cookie("stub_ambassador_id=#{@current_ambassador.id}; path=/; domain=127.0.0.1")
  else
    cookie_jar = Capybara.current_session.driver.browser.current_session.instance_variable_get(:@rack_mock_session).cookie_jar
    cookie_jar[:stub_ambassador_id] = @current_ambassador.id
  end
end