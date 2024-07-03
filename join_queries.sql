-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT
    `students`.`id`,
    `students`.`name`,
    `students`.`surname`,
    `degrees`.`name` AS `degree_name`
FROM
    `students`
JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id`
WHERE
    `degrees`.`name` = 'Corso di Laurea in Economia';



-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze

SELECT
    `degrees`.`id`,
    `degrees`.`name`,
    `degrees`.`level`
FROM
    `degrees`
JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
WHERE
    `departments`.`name` = 'Dipartimento di Neuroscienze' AND `degrees`.`level` = 'Magistrale';



-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT
    `teachers`.`id` AS `id_Fulvio_Amato`,
    `courses`.`id` AS `course_id`,
    `courses`.`name` AS `course_name`
FROM
    `courses`
JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id`
WHERE
    `teachers`.`id` = 44;



-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT
    `students`.`id`,
    `students`.`name` AS `student_name`,
    `students`.`surname` AS `student_surname`,
    `degrees`.*,
    `departments`.`name` AS `department_name`
FROM
    `students`
JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id`
JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
ORDER BY
    `students`.`surname`,
    `students`.`name`;



-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT
    `degrees`.`name` AS `degree_name`,
    `courses`.`name` AS `course_name`,
    `teachers`.`name` AS `teacher_name`,
    `teachers`.`surname` AS `teacher_surname`
FROM
    `degrees`
JOIN `courses` ON `degrees`.`id` = `courses`.`degree_id`
JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id`
ORDER BY
    `degrees`.`name`;



-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica

SELECT
    `teachers`.`id`,
    `teachers`.`name`,
    `teachers`.`surname`,
    `departments`.`name`
FROM
    `teachers`
JOIN `course_teacher` ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses` ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `degrees` ON `courses`.`degree_id` = `degrees`.`id`
JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
WHERE
    `departments`.`name` = 'Dipartimento di Matematica';

-- utilizzando DISTINCT, la query restituirà solo righe uniche per le colonne selezionate, eliminando i duplicati

SELECT DISTINCT
    `teachers`.`id`,
    `teachers`.`name`,
    `teachers`.`surname`,
    `departments`.`name`
FROM
    `teachers`
JOIN `course_teacher` ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses` ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `degrees` ON `courses`.`degree_id` = `degrees`.`id`
JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
WHERE
    `departments`.`name` = 'Dipartimento di Matematica';



-- 7. BONUS: Selezionare per ogni studente il numero di tentativi sostenuti per ogni esame, stampando anche il voto massimo. Successivamente, filtrare i tentativi con voto minimo 18.

SELECT
    `students`.`id` AS `student_id`,
    `students`.`name` AS `student_name`,
    `students`.`surname` AS `student_surname`,
    COUNT(`exam_student`.`vote`) AS `attempt_count`,
    MAX(`exam_student`.`vote`) AS `max_grade`
FROM
    `students`
JOIN `exam_student` ON `students`.`id` = `exam_student`.`student_id`
JOIN `exams` ON `exam_student`.`exam_id` = `exams`.`id`
GROUP BY
    `students`.`id`,
    `exams`.`course_id`
HAVING
    `max_grade` >= 18
ORDER BY
    `students`.`surname`,
    `students`.`name`