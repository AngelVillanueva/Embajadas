Feature: As an Ambassador, I should be able to check the Mission status to know my performance

Scenario: Access to the Mission page is also restricted
  Given I am an Ambassador
  When I try to access the Mission page without previous authentication
  Then I should be prompted to authenticate myself through Facebook

Scenario: Access to the Mission page
  Given I am a logged Ambassador through Facebook
  When I visit the Mission page
  Then I should see the Mission name

Scenario: Missions have Rewards
  Given I am a logged Ambassador through Facebook
    And a Mission has associated Rewards
  When I visit the Mission page
  Then I should see the Mission Rewards

Scenario: Mission is deleted if its Embassy is deleted
  Given an Embassy has available Missions
  When the Embassy is deleted
  Then its Missions should be deleted