Feature: As an Ambassador, I should be able to gain Rewards to increase my engagement

Scenario: Rewards can be won by achieving point targets
  Given I am an Ambassador
    And one of my Missions has a Reward
  When the Ambassador achieves the target points for the Reward
  Then the Ambassador is awarded with a new Badge