Feature: Manage the various Projects
  
  As a Sys Admin I need to be able to set new projects and assign to each project a Project Admin.
  For each project, I need to define it's name, physical address & mail and email 

Scenario: Add a project
  Given I am on the home page
  And I choose option Admin
  When I choose option Add new project
  Then I should be on the Add New Project page
