Feature: Searching for candidates by clicking a state on the Map. 
When a state is clicked, it will redirect the user to that state’s map,
 on which the state’s counties will be selectable. When a county is selected, 
 it will populate the table below with that county’s candidates.

    As a citizen
    So that I can quickly find my candidate,
    I want to get a list of candidates for that county I selected. 

Scenario: click on la county

    When I click on California on the map
    Then I should see a map of counties in California
    When I click on Los Angeles county
    Then I should see a list of candidates in Los Angeles county

Scenario: get county by entering address
    
    When I enter my address
    Then I should see a list of candidates in my county