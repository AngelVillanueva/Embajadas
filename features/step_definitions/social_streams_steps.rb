# Stuff related to the Social streams #

When /^the next Facebook search cycle comes$/ do
  ambassador = Ambassador.first
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
  #Ambassador.last.uid.should == "pepe"
end