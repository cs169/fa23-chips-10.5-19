#Feature: Create New News Item
#  As a user
#  I want to create a new news item with an issue from the dropdown
#
#  Scenario: Successfully creating a news item with valid issue
#    Given I am on the "New News Article" page
#    When I fill in "Title" with "Article Title"
#    And I select "Climate Change" from "Issue"
#    And I fill in the other necessary fields
#    And I click on "Create Article"
#    Then I should see "Article was successfully created."
#    And I should see "Issue: Climate Change"