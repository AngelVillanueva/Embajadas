Feature: As an Ambassador, I should be able to gain Points in order to unlock Rewards

Scenario: an Ambassador can gain points
  Given I am an Ambassador
  When somebody behaves as I have recommended
  Then my points should increase