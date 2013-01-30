Feature: As an Ambassador, I should be able to gain Points in order to unlock Rewards

Scenario: an Ambassador can gain points
  Given I am an Ambassador
  When somebody behaves as I have recommended
  Then my ambassador points should increase

Scenario: an Ambassador can gain points for the Mission
  Given I am an Ambassador
  When somebody behaves as I have recommended
  Then my mission points should increase

Scenario: Points are deleted if the Ambassador is deleted
  Given I am an Ambassador
    And I have some Points
  When the Ambassador is deleted
  Then her points should be deleted

Scenario: Points are deleted if the Mission is deleted
  Given I am an Ambassador
    And I have some Points
  When the Mission is deleted
  Then its points should be deleted

@cookies @wip
Scenario: an Ambassador can gain points (cookies)
  Given I am an Ambassador
    And I have already accepted a Mission
  When somebody behaves as I have recommended clicking my link
  Then my ambassador points should increase