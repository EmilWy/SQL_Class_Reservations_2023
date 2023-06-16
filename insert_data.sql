-- BUILDING
INSERT INTO BUILDING (NAME) VALUES ('Wydzial‚ EITI');
INSERT INTO BUILDING (NAME) VALUES ('Wydzial‚ MEiL');
INSERT INTO BUILDING (NAME) VALUES ('Wydzial‚ WZ');
INSERT INTO BUILDING (NAME) VALUES ('Wydzial‚ Matematyki');

-- ADDRESS
INSERT INTO ADDRESS (street, postal_code, city, building_id) VALUES ('Warynskiego', '00-500', 'Warszawa', 1);
INSERT INTO ADDRESS (street, postal_code, city, building_id) VALUES ('Nowowiejska', '00-500', 'Warszawa', 2);
INSERT INTO ADDRESS (street, postal_code, city, building_id) VALUES ('Koszykowa', '00-500', 'Warszawa', 3);
INSERT INTO ADDRESS (street, postal_code, city, building_id) VALUES ('Wiejska', '00-500', 'Warszawa', 4);

-- MAJOR
INSERT INTO MAJOR (name, semester) VALUES ('Automatyka i Robotyka', 7);
INSERT INTO MAJOR (name, semester) VALUES ('Informatyka', 5);
INSERT INTO MAJOR (name, semester) VALUES ('Mechanika', 6);
INSERT INTO MAJOR (name, semester) VALUES ('Elektrotechnika', 8);
INSERT INTO MAJOR (name, semester) VALUES ('Inzynieria Biomedyczna', 6);
INSERT INTO MAJOR (name, semester) VALUES ('Chemia Techniczna', 7);
INSERT INTO MAJOR (name, semester) VALUES ('Logistyka', 5);
INSERT INTO MAJOR (name, semester) VALUES ('Informatyka Stosowana', 8);

-- EMPLOYEE
INSERT INTO EMPLOYEE (name, surname) VALUES ('Jan', 'Kowalski');
INSERT INTO EMPLOYEE (name, surname) VALUES ('Anna', 'Nowak');
INSERT INTO EMPLOYEE (name, surname) VALUES ('Piotr', 'Lewandowski');
INSERT INTO EMPLOYEE (name, surname) VALUES ('Magdalena', 'Wojcik');
INSERT INTO EMPLOYEE (name, surname) VALUES ('Maria', 'Wojcicka');
INSERT INTO EMPLOYEE (name, surname) VALUES ('Adam', 'Nowicki');
INSERT INTO EMPLOYEE (name, surname) VALUES ('Karolina', 'Kaczmarek');
INSERT INTO EMPLOYEE (name, surname) VALUES ('Tomasz', 'Pawlak');
INSERT INTO EMPLOYEE (name, surname) VALUES ('Marcin', 'Kaminski');
INSERT INTO EMPLOYEE (name, surname) VALUES ('Ewa', 'Wlodarczyk');

-- COURSE
INSERT INTO COURSE (name, ects) VALUES ('Fizyka', 5);
INSERT INTO COURSE (name, ects) VALUES ('Informatyka', 6);
INSERT INTO COURSE (name, ects) VALUES ('Matematyka', 4);
INSERT INTO COURSE (name, ects) VALUES ('Chemia', 5);
INSERT INTO COURSE (name, ects) VALUES ('Biologia', 5);
INSERT INTO COURSE (name, ects) VALUES ('Historia', 4);
INSERT INTO COURSE (name, ects) VALUES ('Psychologia', 6);
INSERT INTO COURSE (name, ects) VALUES ('Ekonomia', 7);
INSERT INTO COURSE (name, ects) VALUES ('Angielski', 3);
INSERT INTO COURSE (name, ects) VALUES ('Programowanie', 6);

-- STUDENT
INSERT INTO STUDENT (name, surname, major_id, ects_total) VALUES ('Jan', 'Nowak', 1, 196);
INSERT INTO STUDENT (name, surname, major_id, ects_total) VALUES ('Katarzyna', 'Kowalczyk', 2, 140);
INSERT INTO STUDENT (name, surname, major_id, ects_total) VALUES ('Michal‚', 'Adamczyk', 3, 180);
INSERT INTO STUDENT (name, surname, major_id, ects_total) VALUES ('Alicja', 'Wisniewska', 4, 220);
INSERT INTO STUDENT (name, surname, major_id, ects_total) VALUES ('Wojciech', 'Kowalczyk', 1, 200);
INSERT INTO STUDENT (name, surname, major_id, ects_total) VALUES ('Barbara', 'Kaminska', 2, 140);
INSERT INTO STUDENT (name, surname, major_id, ects_total) VALUES ('Kamil', 'Adamczyk', 3, 176);
INSERT INTO STUDENT (name, surname, major_id, ects_total) VALUES ('Agnieszka', 'Wojcik', 4, 237);
INSERT INTO STUDENT (name, surname, major_id, ects_total) VALUES ('Marcin', 'Nowicki', 1, 206);
INSERT INTO STUDENT (name, surname, major_id, ects_total) VALUES ('Ewa', 'Lewandowska', 2, 145);

-- CLASSROOM
INSERT INTO CLASSROOM (classroom_number, available, building_id, number_of_seats) VALUES (101, 'Y', 1, 50);
INSERT INTO CLASSROOM (classroom_number, available, building_id, number_of_seats) VALUES (201, 'Y', 2, 80);
INSERT INTO CLASSROOM (classroom_number, available, building_id, number_of_seats) VALUES (301, 'N', 3, 60);
INSERT INTO CLASSROOM (classroom_number, available, building_id, number_of_seats) VALUES (401, 'Y', 4, 70);
INSERT INTO CLASSROOM (classroom_number, available, building_id, number_of_seats) VALUES (102, 'Y', 1, 40);
INSERT INTO CLASSROOM (classroom_number, available, building_id, number_of_seats) VALUES (202, 'N', 2, 70);
INSERT INTO CLASSROOM (classroom_number, available, building_id, number_of_seats) VALUES (302, 'Y', 3, 50);
INSERT INTO CLASSROOM (classroom_number, available, building_id, number_of_seats) VALUES (402, 'Y', 4, 60);
INSERT INTO CLASSROOM (classroom_number, available, building_id, number_of_seats) VALUES (103, 'Y', 1, 45);
INSERT INTO CLASSROOM (classroom_number, available, building_id, number_of_seats) VALUES (203, 'Y', 2, 60);
INSERT INTO CLASSROOM (classroom_number, available, building_id, number_of_seats) VALUES (205, 'Y', 2, 1);

-- COURSE_EMPLOYEE
INSERT INTO COURSE_EMPLOYEE (employee_id, course_id) VALUES (1, 1);
INSERT INTO COURSE_EMPLOYEE (employee_id, course_id) VALUES (2, 2);
INSERT INTO COURSE_EMPLOYEE (employee_id, course_id) VALUES (3, 3);
INSERT INTO COURSE_EMPLOYEE (employee_id, course_id) VALUES (4, 4);
INSERT INTO COURSE_EMPLOYEE (employee_id, course_id) VALUES (1, 2);
INSERT INTO COURSE_EMPLOYEE (employee_id, course_id) VALUES (2, 3);
INSERT INTO COURSE_EMPLOYEE (employee_id, course_id) VALUES (3, 4);
INSERT INTO COURSE_EMPLOYEE (employee_id, course_id) VALUES (4, 1);
INSERT INTO COURSE_EMPLOYEE (employee_id, course_id) VALUES (1, 3);
INSERT INTO COURSE_EMPLOYEE (employee_id, course_id) VALUES (2, 4);

-- STUDENT_COURSE
INSERT INTO STUDENT_COURSE (student_id, course_id) VALUES (1, 1);
INSERT INTO STUDENT_COURSE (student_id, course_id) VALUES (2, 2);
INSERT INTO STUDENT_COURSE (student_id, course_id) VALUES (3, 3);
INSERT INTO STUDENT_COURSE (student_id, course_id) VALUES (4, 4);
INSERT INTO STUDENT_COURSE (student_id, course_id) VALUES (1, 2);
INSERT INTO STUDENT_COURSE (student_id, course_id) VALUES (2, 3);
INSERT INTO STUDENT_COURSE (student_id, course_id) VALUES (3, 1);
INSERT INTO STUDENT_COURSE (student_id, course_id) VALUES (4, 2);
INSERT INTO STUDENT_COURSE (student_id, course_id) VALUES (1, 3);
INSERT INTO STUDENT_COURSE (student_id, course_id) VALUES (2, 4);

-- RESERVATION
INSERT INTO RESERVATION (res_start, res_end, employee_id, course_id, classroom_id) 
VALUES (TO_DATE('2023-09-01 08:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-01 11:00', 'YYYY-MM-DD HH24:MI'), 1, 1, 1);

INSERT INTO RESERVATION (res_start, res_end, employee_id, course_id, classroom_id) 
VALUES (TO_DATE('2023-09-02 09:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-02 12:30', 'YYYY-MM-DD HH24:MI'), 2, 2, 2);

INSERT INTO RESERVATION (res_start, res_end, employee_id, course_id, classroom_id) 
VALUES (TO_DATE('2023-09-03 11:15', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-03 14:15', 'YYYY-MM-DD HH24:MI'), 3, 3, 2);

INSERT INTO RESERVATION (res_start, res_end, employee_id, course_id, classroom_id) 
VALUES (TO_DATE('2023-09-04 13:45', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-04 16:45', 'YYYY-MM-DD HH24:MI'), 4, 4, 4);

INSERT INTO RESERVATION (res_start, res_end, employee_id, course_id, classroom_id) 
VALUES (TO_DATE('2023-09-05 15:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-05 18:30', 'YYYY-MM-DD HH24:MI'), 3, 3, 1);

INSERT INTO RESERVATION (res_start, res_end, employee_id, course_id, classroom_id) 
VALUES (TO_DATE('2023-09-06 10:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-06 13:00', 'YYYY-MM-DD HH24:MI'), 2, 2, 2);

INSERT INTO RESERVATION (res_start, res_end, employee_id, course_id, classroom_id) 
VALUES (TO_DATE('2023-09-07 12:30', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-07 15:30', 'YYYY-MM-DD HH24:MI'), 3, 3, 4);

INSERT INTO RESERVATION (res_start, res_end, employee_id, course_id, classroom_id) 
VALUES (TO_DATE('2023-09-08 14:45', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-08 17:45', 'YYYY-MM-DD HH24:MI'), 4, 4, 4);

INSERT INTO RESERVATION (res_start, res_end, employee_id, course_id, classroom_id) 
VALUES (TO_DATE('2023-09-09 16:15', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-09 19:15', 'YYYY-MM-DD HH24:MI'), 1, 1, 1);

INSERT INTO RESERVATION (res_start, res_end, employee_id, course_id, classroom_id) 
VALUES (TO_DATE('2023-09-10 09:45', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-10 12:45', 'YYYY-MM-DD HH24:MI'), 2, 2, 2);


