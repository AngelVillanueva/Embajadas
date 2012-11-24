Given /^the "(.*?)" Embassy exists$/ do |name|
  FactoryGirl.create(:embassy, name: name)
end

Given /^an Embassy has available Missions$/ do
  embassy = FactoryGirl.create(:embassy)
  m1 = FactoryGirl.create(:mission, name: "Mission 1 for The Embassy", embassy: embassy)
  m2 = FactoryGirl.create(:mission, name: "Mission 2 for The Embassy", embassy: embassy)
end

When /^I access the homepage for the "(.*?)" Embassy$/ do |name|
  embassy_id = Embassy.find_by_name(name).id
  visit embassy_path(embassy_id)
end

When /^I access an Embassy homepage$/ do
  step 'I access the homepage for the "The Embassy" Embassy'
end

Then /^I should see the Embassy welcome information$/ do
  page.should have_selector("title", text: I18n.t("Welcome to the Embassy"))
  page.should have_content("Brand example")
end

Then /^I should see the available Missions$/ do
  page.should have_content("Mission 1 for The Embassy")
  page.should have_content("Mission 2 for The Embassy")
end