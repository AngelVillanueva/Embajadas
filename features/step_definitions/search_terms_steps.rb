## Creating, deleting and updating Slogans, and related stuff ##

Then /^I should not see Search Terms created by other Embassies$/ do
  embassy = Embassy.first
  embassy.available_search_terms.size.should == 1
end