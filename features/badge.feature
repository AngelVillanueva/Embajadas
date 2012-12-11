Feature: As an Ambassador, I should be able to gain Badges to increase my engagement

Scenario: Badges can be won by achieving a Reward target points
  Given I am an Ambassador
    And one of my Missions has a Reward
  When the Ambassador achieves the target points for the Reward
  Then the Ambassador is awarded with a new Badge

Scenario: Badges can we won just once
  Given I am an Ambassador
    And one of my Missions has a Reward
  When I have been awarded with the Badge for that Reward
    And I obtain more points for that Reward
  Then I can not be awarded again with the same Badge