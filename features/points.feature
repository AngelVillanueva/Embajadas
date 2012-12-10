Feature: As an Ambassador, I should be able to gain Points in order to unlock Rewards

Scenario: an Ambassador can gain points
  Given I am an Ambassador
  When somebody behaves as I have recommended
  Then my ambassador points should increase

Scenario: an Ambassador can gain points for the Mission
  Given I am an Ambassador
  When somebody behaves as I have recommended
  Then my mission points should increase