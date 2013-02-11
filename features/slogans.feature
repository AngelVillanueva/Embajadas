Feature: as a Consul I should be able to use "slogans" to track easily my Ambassador's streams

Scenario: a Consul can create slogans in the Brand area
  Given I am a Consul
  When I access the Brand area
  Then I should be able to create relevant slogans

Scenario: a Consul can just assign slogans from her Embassy
  Given I am a Consul
  When I access the Brand area
    And there are some Slogans created
  Then I should see just the slogans created for my Missions