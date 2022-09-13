Feature: User can see his user recommendations
Background: 
    Given a user named "Daniele"
    And "Daniele" likes "Rock"
    And "Daniele" likes "Rap"
    And "Daniele" likes "Metal"
    And a user named "Carlo"
    And "Carlo" likes "Rock"
    And "Carlo" likes "Rap"
    And "Carlo" likes "Metal"                
Scenario: Get user recommendations (Accept)
    Given I am logged in as "Daniele"
    And I am on the recommendations page
    When I press "Genera user reccomendations" 
    Then I should see "Carlo"
    When I press "Follow" 
    And I am on "Carlo" page
    And I press "Followers"
    Then I should see "Daniele"
Scenario: Get user recommendations (Deny)
    Given I am logged in as "Daniele"
    And I am on the recommendations page
    And I press "Genera user reccomendations"
    When I press "OK" 
    Then I should not see "Carlo"
