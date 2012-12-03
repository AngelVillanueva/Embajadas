Feature: As an Ambassador, I should be able to gain Badges to increase my engagement

Scenario: Badges can be won by achieving a Reward target points
  Given I am an Ambassador
    And one of my Missions has a Reward
  When the Ambassador achieves the target points for the Reward
  Then the Ambassador is awarded with a new Badge