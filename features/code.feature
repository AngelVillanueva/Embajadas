Feature: As an Ambassador, I need a code in order to track my performance offline or through forms

Scenario: A code for tracking is generated under Ambassador request
  Given I am an Ambassador
  When I request a Code for a Mission
  Then my code for the Mission should be created

Scenario: A code should be deleted when the Ambassador is deleted
  Given I am an Ambassador
    And I have a Code for a Mission
  When the Ambassador is deleted
  Then her Codes should be deleted

Scenario: A code should be deleted when the Mission is deleted
  Given I am an Ambassador
    And I have a Code for a Mission
  When the Mission is deleted
  Then its Codes should be deleted

