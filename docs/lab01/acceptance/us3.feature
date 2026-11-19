# US-3. As a student, I want to view my grades,
# so that I know my current performance.
# Based on requirement R-06 and corrected R-07 (D-08: a student sees only their own grades).

Feature: Viewing own grades (US-3)

  Background:
    Given student "Ivan Petrenko" of group "KN-31" has the following grades:
      | course            | score | grade |
      | Software Testing  | 91    | A     |
      | Databases         | 64    | E     |

  Scenario: Student sees their own grades
    Given "Ivan Petrenko" is logged in
    When he opens the personal dashboard
    Then he sees 2 courses with scores and ECTS grades:
      | course            | score | grade |
      | Software Testing  | 91    | A     |
      | Databases         | 64    | E     |

  Scenario: Student cannot view grades of another student
    Given "Ivan Petrenko" is logged in
    And student "Mariia Shevchenko" of the same group "KN-31" has grades
    When "Ivan Petrenko" requests GET /api/students/{id}/grades with the id of "Mariia Shevchenko"
    Then the system denies access with status 403
    And the response contains no grades of "Mariia Shevchenko"

  Scenario: Student without grades sees an explanatory message
    Given student "Mariia Shevchenko" has no grades yet
    And "Mariia Shevchenko" is logged in
    When she opens the personal dashboard
    Then she sees the message "You have no grades yet"

  Scenario: Grades are not available without logging in
    Given the user is not logged in
    When the user opens the personal dashboard page
    Then the user is redirected to the university login page
    And no grades are shown
