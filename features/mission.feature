Feature: As an Ambassador, I should be able to check the Mission status to know my performance

Scenario: Access to the Mission page
  Given I am an Ambassador
  When I access the Mission page
  Then I should see the Mission name

Scenario: Missions have Rewards
  Given I am an Ambassador
    And a Mission has associated Rewards
  When I access the Mission page
  Then I should see the Mission Rewards