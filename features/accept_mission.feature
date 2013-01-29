Feature: As an Ambassador I need to accept a Mission in order to start gaining Points for it

Scenario: A Mission needs to be accepted
  Given I am an Ambassador
  When I access the Mission page
  Then I am prompted to accept the Mission

Scenario: An accepted Mission generates a new Assignment
  Given I am an Ambassador
  When I access the Mission page
    And I accept the Mission
  Then a new Assignment should be generated

Scenario: An already accepted Mission could be rejected

# A minister should not be able to accept Missions
# A non accepted Mission should not generate Points