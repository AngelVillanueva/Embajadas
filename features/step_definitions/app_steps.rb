Given /^the "(.*?)" Embassy exists$/ do |name|
  FactoryGirl.create(:embassy, name: name)
end

When /^I access the homepage for the "(.*?)" Embassy$/ do |name|
  embassy_id = Embassy.find_by_name(name).id
  visit embassy_path(embassy_id)
end

When /^I access an Embassy homepage$/ do
end

Then /^I should see the Embassy welcome information$/ do
  page.should have_selector("title", text: I18n.t("Welcome to the Embassy"))
  page.should have_content("Brand example")
end