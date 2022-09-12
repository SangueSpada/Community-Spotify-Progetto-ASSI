Feature: User can see his community recommendations
Background: 
    Given a user named "Daniele"
    And "Daniele" likes "Rock"
    And "Daniele" likes "Rap"
    And "Daniele" likes "Metal"
    And a community named "RRM"
    And "RRM" deals with "Rock"
    And "RRM" deals with "Rap"
    And "RRM" deals with "Metal"                  
Scenario: Get recommendations (Accept)
    Given I am logged in as "Daniele"
    And I am on the recommendations page
    When I press "Genera community reccomendations" 
    Then I should see "RRM"
    When I press "Entra in community" 
    And I go to community "RRM" page
    And I press "Iscritti"
    Then I should see "Daniele"
Scenario: Get recommendations (Deny)
    Given I am logged in as "Daniele"
    And I am on the recommendations page
    And I press "Genera community reccomendations" 
    When I press "OK" 
    Then I should not see "RRM"