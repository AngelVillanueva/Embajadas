Feature: as a Brand, I should have an easy way to track my Ambassador's achivements

Scenario: Pixel tracking
  Given I am a common web user
  When I arrive at a page with a pixel tracker
  Then I should increase the Points count for an Ambassador