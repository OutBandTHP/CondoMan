Feature: Main screen - login and/or Register
  
  Each user must first login or register. before he may access the system

Background: users have been added to database

  Given the following users were created:
  | name            | email                | authority | password | password_confirmation |
  | System Admin    | g.matissh@gmail.com  |       5   | foobar   | foobar                |
  | Projec Admin    | matissh@yahoo.com    |       4   | foobar   | foobar                |
  | Committe member | Com.Mem@gmail.com    |       3   | foobar   | foobar                |
  | Unit Owner      | Unit.Owner@gmail.com |       2   | foobar   | foobar                |
  | Tennat          | Tenant@gmail.com     |       1   | foobar   | foobar                |

Scenario: Login as SysAdmin
  Given I am on the home page
  And I choose menu Login
  Then I should be on the Login page
  When I login as g.matissh@gmail.com with password foobar
  Then I should see menu Admin
  And  I should see menu Create new Project
  And  I should see menu Maintenance
  And  I should see menu Finance
  And  I should not see menu My Status
  
Scenario: Login as Admin
  Given I am on the home page
  And I choose menu Login
  Then I should be on the Login page
  When I login as matissh@yahoo.com with password foobar
  Then I should see menu Admin
  And  I should not see menu Create new Project
  And  I should see menu Maintenance
  And  I should see menu Finance
  And  I should not see menu My Status

Scenario: Login as Committee
  Given I am on the home page
  And I choose menu Login
  Then I should be on the Login page
  When I login as Com.Mem@gmail.com with password foobar
  Then I should not see menu Admin
  And  I should see menu Maintenance
  And  I should see menu Finance
  And  I should see menu My Status

Scenario: Login as Unit Owner
  Given I am on the home page
  And I choose menu Login
  Then I should be on the Login page
  When I login as Unit.Owner@gmail.com with password foobar
  Then I should not see menu Admin
  And  I should not see menu Maintenance
  And  I should not see menu Finance
  And  I should see menu My Status

Scenario: Login as Tenant
  Given I am on the home page
  And I choose menu Login
  Then I should be on the Login page
  When I login as Tenant@gmail.com with password foobar
  Then I should not see menu Admin
  And  I should not see menu Maintenance
  And  I should not see menu Finance
  And  I should see menu My Status
  