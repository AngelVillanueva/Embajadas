Given /^I am a loyal customer$/ do
  # do nothing
end

When /^I access the Embassy Homepage$/ do
  visit root_path
end

Then /^I should see the Embassy welcome information$/ do
  page.should have_selector("title", text: I18n.t("Welcome to the Embassy"))
end 