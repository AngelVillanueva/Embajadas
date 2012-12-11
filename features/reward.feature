Feature: as a Consul I should be able to create Rewards to guide my Ambassadors efforts

Scenario: Rewards are deleted when its Missions are deleted
  Given an Embassy has available Missions
    And a Mission has associated Rewards
  When the Mission is deleted
  Then its Rewards should be deleted