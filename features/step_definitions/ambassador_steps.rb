Given /^I am an Ambassador$/ do
  step "an Embassy has available Missions"
  ambassador = FactoryGirl.create(:ambassador)
  ambassador.embassies << Embassy.first
end

Then /^the Ambassador should persist in the database$/ do
  Ambassador.last.name.should == "facebookman"
end

Then /^her auth Token should be stored$/ do
  Ambassador.last.oauth_token.should == "456"
end