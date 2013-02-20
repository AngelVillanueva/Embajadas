# Stuff related to the Social streams #

When /^the next Facebook search cycle comes$/ do
  ambassador = Ambassador.first
  slogan = Slogan.first.search_term.term
  matches = ambassador.fb_slogan_search(slogan)
  matches.size.should == 1
  matches.first["message"].should == slogan
end

Then /^the post should be stored in the database$/ do
  slogan = Slogan.first.search_term.term
  Post.last.ambassador_id.should = Ambassador.first.id
  Post.last.content.should == slogan
end