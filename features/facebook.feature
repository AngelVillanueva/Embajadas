Feature: as an Ambassador I should be able to gain points by posting in my Facebook stream

Scenario: any Mission can select relevant "slogans" to be used to gain points
  Given I am a Consul
  When I access the Brand area
    And I create a new Mission
  Then I should be able to add relevant slogans for that Mission

Scenario: an Ambassador can gain points by posting slogan in Facebook (or Twitter)
  Given I am an Ambassador
    And one of my Missions has at least one Slogan
  When I post the Slogan in my Facebook stream
  Then my points should be increased