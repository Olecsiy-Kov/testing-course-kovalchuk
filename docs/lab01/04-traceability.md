# Матриця простежуваності

Матриця пов’язує вимоги специфікації (у виправлених формулюваннях з [01-requirements-review.md](01-requirements-review.md)), ризики ([03-risk-register.md](03-risk-register.md)), вимоги до якості ([02-quality-requirements.md](02-quality-requirements.md)) і сценарії приймання ([acceptance/](acceptance/)). На наступних лабораторних роботах до неї додаватиметься колонка з автоматизованими тестами.

## 1. Вимоги → ризики, вимоги до якості, сценарії

| Вимога | Ризики | Вимоги до якості | Сценарії приймання |
| --- | --- | --- | --- |
| Р-01 | РП-09, РП-11 | ЯВ-02 | US-2: «Administrator adds a student with valid data», «Student with invalid data is not created», «Teacher cannot add a student». **Прогалина:** немає сценаріїв для зміни та видалення студента |
| Р-02 | РП-09 | — | US-2: «Email that differs only in letter case is rejected as a duplicate» |
| Р-03 | РП-07 | ЯВ-05 | — (нефункціональна вимога; перевіряється навантажувальним тестом) |
| Р-04 | РП-02, РП-03 | ЯВ-01, ЯВ-07 | US-1: «ECTS grade is derived from the score», «Invalid score is rejected», «Teacher cannot grade a course that is not assigned to them» |
| Р-05 | РП-03 | ЯВ-01 | US-1: «ECTS grade is derived from the score» |
| Р-06 | РП-01 | ЯВ-02 | US-3: «Student sees their own grades», «Student without grades sees an explanatory message», «Grades are not available without logging in» |
| Р-07 | РП-01 | ЯВ-02 | US-3: «Student cannot view grades of another student» |
| Р-08 | РП-06 | — | US-1: «Teacher corrects a score within the allowed period and the change is logged», «Teacher cannot correct a score after the allowed period» |
| Р-09 | РП-12 | ЯВ-07, ЯВ-08 | US-1: «Invalid score is rejected» (частково — повідомлення про помилку) |
| Р-10 | РП-08 | ЯВ-04 | — (нефункціональна вимога; перевіряється тестом на витривалість і моніторингом) |
| Р-11 | РП-05 | ЯВ-05 | **Прогалина:** немає історії користувача і сценаріїв для формування відомості |
| Р-12 | РП-01, РП-11 | ЯВ-02 | US-3: «Student cannot view grades of another student», «Grades are not available without logging in» |
| Р-13 | РП-04 | ЯВ-03 | US-1: «Teacher corrects a score within the allowed period and the change is logged» |
| Р-14 | РП-07 | ЯВ-06 | — (нефункціональна вимога; перевіряється тестом ємності) |
| Р-15 | — | — | US-2: «Administrator adds a student with valid data», «Student with invalid data is not created» (домен пошти); US-3: «Grades are not available without logging in» |
| Р-16 | РП-10 | — | **Прогалина:** сценарії відкладено до відповіді замовника на питання Д-18 |

## 2. Ризики високого рівня → перевірки

| Ризик | Рівень | Вимоги до якості | Сценарії приймання | Чи є перевірка |
| --- | --- | --- | --- | --- |
| РП-03 | 9 | ЯВ-01, ЯВ-07 | US-1: «ECTS grade is derived from the score», «Invalid score is rejected» | Так |
| РП-01 | 6 | ЯВ-02 | US-3: «Student cannot view grades of another student» | Так |
| РП-02 | 6 | ЯВ-02 | US-1: «Teacher cannot grade a course that is not assigned to them» | Так |
| РП-04 | 6 | ЯВ-03 | US-1: «Teacher corrects a score within the allowed period and the change is logged» | Так |
| РП-05 | 6 | ЯВ-05 (лише час формування) | — | **Частково:** коректність вмісту відомості перевірятиметься інтеграційними тестами (див. реєстр ризиків); потрібна історія користувача для Р-11 |

## 3. Висновки з матриці

- Усі ризики високого рівня мають щонайменше одну перевірку; для РП-05 бракує сценарію приймання.
- Вимоги без жодного сценарію: Р-11 і Р-16 (функціональні — прогалини, які треба закрити), а також Р-03, Р-10, Р-14 (нефункціональні — покриваються вимогами до якості ЯВ-04…ЯВ-06).
- Для Р-01 не покрито зміну та видалення студента.
- Під час зміни вимоги (наприклад, після відповіді замовника щодо Д-05 або Д-09) за рядком вимоги в таблиці 1 знаходимо всі пов’язані ризики, вимоги до якості й сценарії, які треба переглянути.
