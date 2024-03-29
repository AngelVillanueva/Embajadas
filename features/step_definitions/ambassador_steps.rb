Given /^I am an Ambassador$/ do
  step "an Embassy has at least an available Mission"
  ambassador = FactoryGirl.create(:ambassador)
  ambassador.embassies << Embassy.first
end

Given /^I am an Ambassador signed in with provider "(.*?)"$/ do |provider|
  ambs = Ambassador.count
  #Capybara.default_host = 'example.org' # makes to fail all the other tests
  visit "/ambassadors/auth/#{provider.downcase}"
  Ambassador.count.should == ambs + 1
  ambassador = Ambassador.last
  f_ambassador = create_Facebook("pepe", "")
  ambassador.oauth_token = f_ambassador["access_token"]
  ambassador.extend_fb_token
  delete_Facebook f_ambassador["id"]
end

Given /^I am a logged Ambassador through (.*?)$/ do |provider|
  step "I am an Ambassador"
  @current_ambassador = Ambassador.last
  log_in
  visit "/ambassadors/auth/#{provider.downcase}"
end

When /^I visit my own Ambassador area$/ do
  visit ambassador_path(Ambassador.first)
end

When /^I visit the Ambassador area of other Ambassador$/ do
  ambassador_two = FactoryGirl.create(:ambassador, name: "Ambassador_two", email: "ambassador_two@example.com")
  visit ambassador_path(ambassador_two)
end

When /^a potential Ambassador follows a link to join my Embassy$/ do
  code = MailingCode.first.tracking_code
  visit new_ambassador_registration_path(etr: code)
end

When /^she accepts to join my Embassy$/ do
  step "I am a logged Ambassador through Facebook"
end

When /^I log in through Facebook$/ do
  step 'I am an Ambassador signed in with provider "Facebook"'
end

Then /^I should be prompted to authenticate myself through (.*?)$/ do |provider|
  page.should have_css("##{provider.downcase}_sign_in")
end

Then /^the Ambassador should persist in the database$/ do
  Ambassador.last.name.should == "facebookman"
end

Then /^her auth Token should be stored$/ do
  Ambassador.last.oauth_token.should_not == nil
end

Then /^she should join the Embassy$/ do
  page.should have_content(I18n.t("ambassador_area.hello", name: @current_ambassador.name))
  page.should have_content(Embassy.first.name)
  page.should have_css('a', href: embassy_path(Embassy.first))
end

Then /^my oauth token expires_at should be extended$/ do
  ambassador = Ambassador.last
  ambassador.oauth_expires_at.should > 50.days.from_now
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