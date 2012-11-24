Given /^I am a loyal customer$/ do
  # do nothing
end

When /^I access the homepage for the "(.*?)" Embassy$/ do |name|
  embassy = FactoryGirl.create(:embassy, name: name)
  embassy_id = Embassy.find_by_name(name).id
  visit embassy_path(embassy_id)
end

Then /^I should see the Embassy welcome information$/ do
  page.should have_selector("title", text: I18n.t("Welcome to the Embassy"))
  page.should have_content("Brand example")
end