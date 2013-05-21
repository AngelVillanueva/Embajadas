# Stuff related to the Social streams #

Given /^I have not authorized the app with read_permissions$/ do
  # create test account in Facebook - see support module 'facebook_test'
  response = create_Facebook("pepi", "")
  # update token in mock Ambassador to be able to call Facebook api
  ambassador = Ambassador.first
  ambassador.uid = response["id"]
  ambassador.oauth_token = response["access_token"]
  ambassador.save!
  # check read_permissions
  ambassador.fb_read_permission?.should == nil
end

When /^the next Facebook search cycle comes$/ do
  ambassador = Ambassador.first
  ambassador.points.count.should == 0
  slogan_id = Slogan.first.id
  slogan = Slogan.first.search_term.term
  matches = ambassador.fb_slogan_search(slogan_id)
  matches.size.should == 1
  matches.first["message"].should == slogan
end

Then /^the post should be stored in the database$/ do
  slogan = Slogan.first.search_term.term
  Post.all.size.should == 1
  Post.last.ambassador_id.should == Ambassador.first.id
  Post.last.message.should == slogan
end

Then /^the points of the related Missions should be increased$/ do
  delete_Facebook(Ambassador.last.uid).should == "true"
  ambassador = Ambassador.first
  ambassador.points.count.should == 1
end

Then /^I should be noticed that the permission is needed$/ do
  delete_Facebook(Ambassador.last.uid).should == "true"
  page.should have_css(".flash.alert-notice", text: I18n.t("flash.Read_permission needed"))
end