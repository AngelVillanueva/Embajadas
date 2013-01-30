Feature: As the application developer I need the Ambassador tracking id to be stored in a cookie in order to track the Ambassador performance

@cookies @wip
Scenario: when somebody arrives to the Cooker page a Cookie is set if any Ambassador tracking id is in the url
  Given I am a common web surfer
    And an Ambassador has assigned Missions
  When I click a link in any Internet page containing the Ambassador tracking id
  Then a cookie should be set in my browser storing the Ambassador tracking id