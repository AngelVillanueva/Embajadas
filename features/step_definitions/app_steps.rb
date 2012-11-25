Given /^the "(.*?)" Embassy exists$/ do |name|
  FactoryGirl.create(:embassy, name: name)
end

Given /^I am an Ambassador$/ do
  step "an Embassy has available Missions"
  embassy = Embassy.find(1)
  ambassador = FactoryGirl.create(:ambassador, embassy: embassy)
end

Given /^an Embassy has available Missions$/ do
  embassy = FactoryGirl.create(:embassy)
  m1 = FactoryGirl.create(:mission, name: "Mission 1 for The Embassy", embassy: embassy)
  m2 = FactoryGirl.create(:mission, name: "Mission 2 for The Embassy", embassy: embassy)
end

When /^I visit the homepage for the "(.*?)" Embassy$/ do |name|
  embassy_id = Embassy.find_by_name(name).id
  visit embassy_path(embassy_id)
end

When /^I access the homepage for the "(.*?)" Embassy$/ do |name|
  embassy_id = Embassy.find_by_name(name).id
  visit embassy_path(embassy_id)
  fill_in 'ambassador_email', with: "imontoya@example.com"
  fill_in 'ambassador_password', with: "foobar"
  click_button 'Sign in'
end

When /^I access an Embassy homepage$/ do
  step 'I access the homepage for the "The Embassy" Embassy'
end

When /^I access my Embassy homepage$/ do
  step "I access an Embassy homepage"
end

When /^I access the homepage of another Embassy$/ do
  another_embassy = FactoryGirl.create(:embassy, name: "Another Embassy")
  visit embassy_path(another_embassy)
  fill_in 'ambassador_email', with: "imontoya@example.com"
  fill_in 'ambassador_password', with: "foobar"
  click_button "Sign in"
end

Then /^I should be prompted to authenticate myself$/ do
  page.should have_css("form[action*='/ambassadors/sign_in']")
end

Then /^I should see the Embassy welcome information$/ do
  page.should have_selector("title", text: I18n.t("Welcome to the Embassy"))
  page.should have_content("Brand example")
end

Then /^I should see the available Missions$/ do
  page.should have_content("Mission 1 for The Embassy")
  page.should have_content("Mission 2 for The Embassy")
end

Then /^I should be redirected to the global homepage$/ do
  current_path.should == root_path
end