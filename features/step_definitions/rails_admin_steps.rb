Given /^there are one Ambassador from each of the previous weeks$/ do
  a1 = FactoryGirl.create(:ambassador, name: "A1", email: "a1@example.com", created_at: 1.week.ago)
  a2 = FactoryGirl.create(:ambassador, name: "A2", email: "a2@example.com", created_at: 2.week.ago)
  a1.embassies << Embassy.first
  a2.embassies << Embassy.first
end

Then /^I should see the Ambassador evolution graph$/ do
  page.should have_css(".popover-ambassadors")
end

Then /^I should see a total of two Ambassadors$/ do
  page.should have_css(".popover-ambassadors .right strong", text: "2")
end

Then /^I should see none Ambassadors for the first five weeks and two for the last ones$/ do
  page.find(".popover-ambassadors .peity_bar_good span span").should have_content("0,0,0,0,0,1,1")
  page.should have_css(".popover-ambassadors .peity_bar_good span span", text: "0,0,0,0,0,1,1")
end

Then /^I should see a the right Ambassador growth from previous to last week$/ do
  page.find(".popover-ambassadors .peity_bar_good").should have_content("0%")
end