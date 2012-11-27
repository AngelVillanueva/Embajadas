Feature: As an Ambassador, I should be able to gain Rewards to increase my engagement

Scenario: Missions have Rewards
  Given I am an Ambassador
    And a Mission has associated Rewards
  When I access the Mission page
  Then I should see the Mission Rewards