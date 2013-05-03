Feature: As a Consul I want my Ambassadors to join Incitatus through my Embassy

Scenario: an Ambassador joins an Embassy after the Consul invitation
  Given I am a Consul
  When a potential Ambassador follows a link to join my Embassy
    And she accepts to join my Embassy
  Then she should join the Embassy
