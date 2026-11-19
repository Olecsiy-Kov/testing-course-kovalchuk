# US-2. As an administrator, I want to add a new student,
# so that the student can log in and see their grades.
# Based on corrected requirements R-01 (D-01), R-02 (D-02) and R-15 (D-17: domain @univ.edu.ua).

Feature: Adding a new student (US-2)

  Background:
    Given the dean's office administrator is logged in
    And group "KN-31" exists

  Scenario: Administrator adds a student with valid data
    When the administrator creates a student with:
      | full name     | Mariia Shevchenko         |
      | email         | m.shevchenko@univ.edu.ua  |
      | group         | KN-31                     |
      | year of entry | 2024                      |
    Then the student "Mariia Shevchenko" appears in the list of group "KN-31"
    And "Mariia Shevchenko" can log in with "m.shevchenko@univ.edu.ua" and sees an empty list of grades

  Scenario: Email that differs only in letter case is rejected as a duplicate
    Given a student with email "i.petrenko@univ.edu.ua" already exists
    When the administrator creates a student with email "I.Petrenko@UNIV.edu.ua"
    Then the system rejects the request with status 409 and the message "A student with this email already exists"
    And the number of students does not change

  Scenario Outline: Student with invalid data is not created
    When the administrator creates a student with <field> set to "<value>"
    Then the system shows the error "<message>" next to the field <field>
    And the number of students does not change

    Examples:
      | field         | value                  | message                                         |
      | email         | m.shevchenko@gmail.com | Use a university email (@univ.edu.ua)           |
      | email         | not-an-email           | Enter a valid email                             |
      | full name     |                        | Full name is required                           |
      | group         | XX-99                  | Group does not exist                            |
      | year of entry | 1999                   | Year of entry must be from 2000 to current year |

  Scenario: Teacher cannot add a student
    Given the teacher "Olena Kovalenko" is logged in instead of the administrator
    When the teacher sends POST /api/students with valid student data
    Then the system denies access with status 403
    And the number of students does not change
