Feature: Manage the various Projects
  
  As a Sys Admin I need to be able to set new projects and assign to each project a Project Admin.
  For each project, I need to define it's name, physical address & mail and email 

Background: projects have been added to database

  Given the following projects exist:
  | name               | address     | admin               | email |
  | Rishon Lezion 21   | RL 21       | matissh@yahoo.com   | VaadRl21@gmail.com  |
  | Dankner 21-23      | Dankner 23  | g.matissh@gmail.com | Vaad2123@gmail.com  |

Scenario: Add a project
  Given I am on the home page
  And I choose menu Admin
  When I choose menu Add new project
  Then I should be on the Add New Project page
