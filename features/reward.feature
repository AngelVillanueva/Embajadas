Feature: As an Ambassador, I should be able to gain Rewards to increase my engagement
@wip
Scenario: Rewards can be won by achieving point targets
  Given I am an Ambassador
    And one of my Missions has a Reward
  When the Ambassador achieves the Reward's point target
  Then the Ambassador gains the Reward