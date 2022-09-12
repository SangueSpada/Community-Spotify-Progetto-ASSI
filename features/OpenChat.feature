Feature: User can open a chat
Background: 
    Given a user named "Carlo"
    And a user named "Daniele"
Scenario: Open a Chat as a followers
    Given "Daniele" is a follower of "Carlo"
    And I am logged in as "Daniele"
    And I see "Carlo" user page
    When I press "Chat"
    Then "Daniele" is on the chat page with "Carlo"
Scenario: Open a Chat without being a follower
    Given I am logged in as "Daniele"
    When I go to "Carlo" page
    Then I should not see "Chat"