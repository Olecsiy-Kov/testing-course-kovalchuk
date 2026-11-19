# US-1. As a teacher, I want to give a student points for a course,
# so that the system automatically determines the student's ECTS grade.
# Based on corrected requirements R-04, R-05 (assumption D-05: 0-34 F, 35-59 FX),
# R-08 (D-09: 72 hours) and R-13 (D-15).

Feature: Grading and ECTS grade calculation (US-1)

  Background:
    Given the teacher "Olena Kovalenko" is logged in
    And the course "Software Testing" is assigned to the teacher
    And student "Ivan Petrenko" of group "KN-31" is enrolled in the course "Software Testing"

  Scenario Outline: ECTS grade is derived from the score
    When the teacher enters <score> points for "Ivan Petrenko" in "Software Testing"
    Then the score is saved
    And the student's dashboard shows grade "<grade>"

    Examples: Boundaries of every ECTS range
      | score | grade |
      | 100   | A     |
      | 90    | A     |
      | 89    | B     |
      | 82    | B     |
      | 81    | C     |
      | 75    | C     |
      | 74    | D     |
      | 67    | D     |
      | 66    | E     |
      | 60    | E     |
      | 59    | FX    |
      | 35    | FX    |
      | 34    | F     |
      | 0     | F     |

  Scenario Outline: Invalid score is rejected
    Given "Ivan Petrenko" already has 70 points in "Software Testing"
    When the teacher enters "<value>" points for "Ivan Petrenko" in "Software Testing"
    Then the system rejects the score with the message "Enter a whole number from 0 to 100"
    And "Ivan Petrenko" still has 70 points and grade "D" in "Software Testing"

    Examples:
      | value | case              |
      | -1    | below the range   |
      | 101   | above the range   |
      | 85.5  | fractional number |
      | abc   | not a number      |
      |       | empty value       |

  Scenario: Teacher cannot grade a course that is not assigned to them
    Given the course "Databases" is not assigned to the teacher
    And "Ivan Petrenko" is enrolled in the course "Databases"
    When the teacher enters 80 points for "Ivan Petrenko" in "Databases"
    Then the system denies access with status 403
    And no score is saved for "Ivan Petrenko" in "Databases"

  Scenario: Teacher corrects a score within the allowed period and the change is logged
    Given the teacher entered 58 points for "Ivan Petrenko" in "Software Testing" 2 hours ago
    When the teacher changes the score to 61 points
    Then the student's dashboard shows grade "E"
    And the grade change log contains an entry with the teacher, the time, the old score 58 and the new score 61

  Scenario: Teacher cannot correct a score after the allowed period
    Given the teacher entered 58 points for "Ivan Petrenko" in "Software Testing" 73 hours ago
    When the teacher changes the score to 61 points
    Then the system rejects the change with a message that only the dean's office can change the score now
    And "Ivan Petrenko" still has 58 points in "Software Testing"
