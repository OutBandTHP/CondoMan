Feature: Manage the various Projects
  
  As a Sys Admin I need to be able to set new projects and assign to each project a Project Admin. The Project Admin, 
  unless already defined as a user, will be invited to create his login account on the system.
  
  For each project, either me or the Project's admin need to define it's name, physical address, email, no. of buildings and units.
  Later, I should be able to define for each building its own address and ID (which was set as a default to a running number). 
  Thereafter, I need to define each unit in terms of location (buildingh, floor and unit number).  

Background: admin users have been added to database

  Given the following users were created:
  | name            | email                | authority | password | password_confirmation |
  | System Admin    | g.matissh@gmail.com  |       5   | foobar   | foobar                |
  | Projec Admin    | existing@user.com    |       4   | foobar   | foobar                |
  
Scenario Outline: Add a project
  Given I am on the home page
  And I choose menu Login
  Then I should be on the Login page
  Then I login as g.matissh@gmail.com with password foobar
  When I choose menu Admin
  And I choose menu Create new Project
  Then I should be on the Add New Project page
  And I create the project <project>, managed by <admin> with <buildings> buildings and <units> units
  Then I should see <project> was successfully created
  And I can find user by email <admin>
  And there are <buildings> buildings
  And there are <units> units

  Examples:
    | project  | buildings | units | admin              |
    | Prject 1 |         1 |     1 | matissh@yahoo.com  | 
    | Prject 2 |         2 |     5 | existing@user.com  |
    