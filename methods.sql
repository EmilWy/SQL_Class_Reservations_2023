----------------------------------------------------------------------------------------------------------------------------------
--Procedury
----------------------------------------------------------------------------------------------------------------------------------
--Procedura, która wyœwietli n zajêæ odbywaj¹cych siê w danej sali, prowadz¹cego, przedmiot i data
--Przyjmue - numer sali, budynek i liczbê rezerwacji n

CREATE OR REPLACE PROCEDURE  reservations (classroom_num NUMBER, building_num NUMBER, no_reserv NUMBER)
AS
CURSOR c_reservations IS
    SELECT e.name, e.surname, c.name as course, re.res_start, re.res_end
    FROM reservation re
    JOIN employee e using(employee_id)
    JOIN course c using (course_id)
    JOIN classroom cr using (classroom_id)
    JOIN building b on (b.building_id=cr.building_id)
    WHERE cr.classroom_number = classroom_num AND b.building_id = building_num
    ORDER BY re.res_start ASC
    FETCH FIRST no_reserv ROWS WITH TIES;
    
    r_reservation c_reservations%ROWTYPE;
    v_start_time NUMBER;
    v_end_time NUMBER;
BEGIN
   OPEN c_reservations;
    LOOP
        FETCH c_reservations INTO r_reservation;
        EXIT WHEN c_reservations%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Teacher: ' || r_reservation.name || ' ' || r_reservation.surname);
        DBMS_OUTPUT.PUT_LINE('Subject: ' || r_reservation.course);
        DBMS_OUTPUT.PUT_LINE('Date: ' || TO_CHAR(r_reservation.res_start));
        DBMS_OUTPUT.PUT_LINE('Class Time: ' || TO_CHAR(r_reservation.res_start, 'HH24') || ':' || TO_CHAR(r_reservation.res_start, 'MI') || ' - ' || TO_CHAR(r_reservation.res_end, 'HH24') || ':' || TO_CHAR(r_reservation.res_end, 'MI'));
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;
    CLOSE c_reservations;
END;
/

SET SERVEROUTPUT ON;
BEGIN
  reservations(101, 1, 3);
END;
/
----------------------------------------------------------------------------------------------------------------------------------
--Procedura, informujaca studenta o jego najbli¿szych zajêciach, gdzie siê odbywaja oraz kto je prowadzi
--Przyjmuje - id_studenta

CREATE OR REPLACE PROCEDURE  student_classes (student_num NUMBER)
AS
CURSOR student_clas IS
    SELECT c.name, r.res_start, r.res_end, cr.classroom_number, b.name as building, a.street, a.city
    FROM student_course sc
    JOIN course c on (c.course_id = sc.course_id)
    join reservation r on (c.course_id = r.course_id)
    JOIN employee e using(employee_id)
    JOIN classroom cr using (classroom_id)
    JOIN building b on (b.building_id=cr.building_id)
    JOIN address a on (a.building_id=cr.building_id)
    WHERE sc.student_id = student_num;
    
    v_student_classes student_clas%ROWTYPE;
BEGIN
   OPEN student_clas;
    LOOP
        FETCH student_clas INTO v_student_classes;
        EXIT WHEN student_clas%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Subject: ' || v_student_classes.name);
        DBMS_OUTPUT.PUT_LINE('Classroom: ' || v_student_classes.classroom_number || ' | ' || 'Building: ' || v_student_classes.building);
        DBMS_OUTPUT.PUT_LINE('Address: ' || v_student_classes.street || ' | ' || 'City: ' || v_student_classes.city);
        DBMS_OUTPUT.PUT_LINE('Date: ' || v_student_classes.res_start);
        DBMS_OUTPUT.PUT_LINE('Class Time: ' || TO_CHAR(v_student_classes.res_start, 'HH24') || ':' || TO_CHAR(v_student_classes.res_start, 'MI') || ' - ' || TO_CHAR(v_student_classes.res_end, 'HH24') || ':' || TO_CHAR(v_student_classes.res_end, 'MI'));
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;
    CLOSE student_clas;
END;
/
SET SERVEROUTPUT ON;
BEGIN
  student_classes(1);
END;
/
----------------------------------------------------------------------------------------------------------------------------------
--Funkcje
----------------------------------------------------------------------------------------------------------------------------------
--Funkcja, do obliczania iloœci punktów ECTS danego studenta oraz informuje jezeli btakuje do zdania
--Przyjmuje id_studenta

CREATE OR REPLACE TYPE student_info AS OBJECT (
  ECTS_num NUMBER,
  ECTS_num_short NUMBER,
  ECTS_num_above NUMBER
);
/

CREATE OR REPLACE FUNCTION punkty_ECTS(student_num NUMBER)
RETURN student_info
AS
  ECTS_num NUMBER := 0;
  ECTS_need CONSTANT NUMBER := 30;
  stud_name VARCHAR2(30);
  stud_surname VARCHAR2(30);
  stud_ECTS_total NUMBER;
  stud_ECTS_short NUMBER;
  stud_ECTS_above NUMBER;
  stud_semester VARCHAR2(30);
  stud student_info;
BEGIN
    SELECT sum(ECTS)
    INTO ECTS_num
    FROM student s
    LEFT JOIN student_course sc on (s.student_id=sc.student_id)
    LEFT JOIN course c using (course_id)
    WHERE s.student_id = student_num
    GROUP BY s.student_id;
    
    SELECT s.name, s.surname, m.semester, s.ECTS_total
    INTO stud_name, stud_surname, stud_semester, stud_ECTS_total
    FROM student s
    JOIN major m using (major_id)
    WHERE s.student_id = student_num;
    
    IF ECTS_num is null THEN
        ECTS_num :=0;
    END IF;
    
    IF ECTS_num + stud_ECTS_total >= ECTS_need*stud_semester THEN
        stud_ECTS_above := ECTS_num + stud_ECTS_total - ECTS_need*stud_semester;
        stud := student_info(ECTS_num, 0, stud_ECTS_above);
    ELSE
        stud_ECTS_short := ECTS_num + stud_ECTS_total - ECTS_need*stud_semester;
        stud := student_info(ECTS_num, -stud_ECTS_short, 0);
    END IF;
    RETURN stud;
END;
/
-- Test do sprawdzenia liczby punktów ECTS dla ka¿dego z uczniów
SELECT student_id, punkty_ECTS(student_id).ECTS_num AS ects_points, 
    punkty_ECTS(student_id).ECTS_num_short AS ECTS_short,
    punkty_ECTS(student_id).ECTS_num_above AS ECTS_above
FROM student;
----------------------------------------------------------------------------------------------------------------------------------
--Funkcja, zwracaj¹ca liczbê studentów którzy bêd¹ uczestniczyæ na zajêciach 
--Przyjmuje id przedmiotu

CREATE OR REPLACE FUNCTION amount_of_students(course_num NUMBER)
RETURN Number
AS
  v_stud_number NUMBER := 0;
BEGIN
    SELECT count(sc.student_id)
    INTO v_stud_number
    FROM course c
    LEFT JOIN student_course sc on (c.course_id=sc.course_id)
    WHERE c.course_id = course_num
    GROUP BY c.course_id;
    
    IF v_stud_number is null THEN
        v_stud_number :=0;
    END IF;
    
    RETURN v_stud_number;
END;
/    
--Test do sprawdzenia iloœci osób na wszystkich kursach
SELECT course_id, amount_of_students(course_id) AS students_attending
FROM course;
----------------------------------------------------------------------------------------------------------------------------------
--Wyzwalacze
----------------------------------------------------------------------------------------------------------------------------------
--Wyzwalacz, który oddaje b³¹d je¿eli liczba uczestnicz¹cych uczniów na zajêciach bêdzie wiêksza ni¿ 
--liczba miejsc w klasie, albo klasa jest niedostêpna

CREATE OR REPLACE TRIGGER check_class
BEFORE INSERT ON reservation
FOR EACH ROW
DECLARE
  v_capacity NUMBER;
  v_number_od_students NUMBER;
  v_classroom_available VARCHAR2(1);
BEGIN
  SELECT number_of_seats, available
  INTO v_capacity, v_classroom_available
  FROM classroom
  WHERE classroom_id = :new.classroom_id;

  SELECT amount_of_students(course_id)
  INTO v_number_od_students
  FROM course
  WHERE course_id = :new.course_id;

  IF v_classroom_available ~= 'Y' THEN
    RAISE_APPLICATION_ERROR(-20002, 'The class is unavailable. Cannot add reservation.');
  END IF;

  IF v_number_od_students > v_capacity THEN
    RAISE_APPLICATION_ERROR(-20001, 'Cannot add reservation. The capacity of the class has been exceeded.');
  END IF;
END;
/
ALTER TRIGGER check_class ENABLE;


--Test b³êdu próby stworzenia rezerwacji na niedostêpnej klasie
INSERT INTO RESERVATION (res_start, res_end, employee_id, course_id, classroom_id) 
VALUES (TO_DATE('2023-09-02 11:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-02 12:00', 'YYYY-MM-DD HH24:MI'), 1, 1, 3);
--Test b³êdu próby stworzenia rezerwacji je¿eli liczba osób na kursie jest wiêksza od liczby miejsc w klasie
INSERT INTO RESERVATION (res_start, res_end, employee_id, course_id, classroom_id) 
VALUES (TO_DATE('2023-09-02 16:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-02 17:00', 'YYYY-MM-DD HH24:MI'), 1, 1, 11);
----------------------------------------------------------------------------------------------------------------------------------
--Wyzwalacz, który zakazuje rezerwacji, je¿eli nowa rezerwacja nak³adaja siê dat¹, godzin¹ i klas¹

CREATE OR REPLACE TRIGGER check_reservation_timing
BEFORE INSERT OR UPDATE ON reservation
FOR EACH ROW
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_count
  FROM reservation
  WHERE (TO_DATE(:new.res_start, 'YYYY-MM-DD HH24:MI') BETWEEN TO_DATE(res_start, 'YYYY-MM-DD HH24:MI') AND TO_DATE(res_end, 'YYYY-MM-DD HH24:MI')
         OR TO_DATE(:new.res_end, 'YYYY-MM-DD HH24:MI') BETWEEN TO_DATE(res_start, 'YYYY-MM-DD HH24:MI') AND TO_DATE(res_end, 'YYYY-MM-DD HH24:MI')
         OR TO_DATE(res_start, 'YYYY-MM-DD HH24:MI') BETWEEN TO_DATE(:new.res_start, 'YYYY-MM-DD HH24:MI') AND TO_DATE(:new.res_end, 'YYYY-MM-DD HH24:MI')
         OR TO_DATE(res_end, 'YYYY-MM-DD HH24:MI') BETWEEN TO_DATE(:new.res_start, 'YYYY-MM-DD HH24:MI') AND TO_DATE(:new.res_end, 'YYYY-MM-DD HH24:MI'))
    AND classroom_id = :new.classroom_id
    AND reservation_id != :new.reservation_id
    AND :new.reservation_id IS NOT NULL;
  IF v_count > 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Cannot create overlapping reservation.');
  END IF;
END;
/
ALTER TRIGGER check_reservation_timing ENABLE;
SET SERVEROUTPUT ON;

--Test b³êdu, po drugim insert tej samej rezerwacji wypada b³¹d
INSERT INTO RESERVATION (res_start, res_end, employee_id, course_id, classroom_id) 
VALUES (TO_DATE('2023-09-01 11:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-01 12:00', 'YYYY-MM-DD HH24:MI'), 1, 1, 4);
INSERT INTO RESERVATION (res_start, res_end, employee_id, course_id, classroom_id) 
VALUES (TO_DATE('2023-09-01 11:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-09-01 12:00', 'YYYY-MM-DD HH24:MI'), 1, 1, 4);



--drop table "Z09"."CLASSROOM" cascade constraints;
--drop table "Z09"."ADDRESS" cascade constraints;
--drop table "Z09"."BUILDING" cascade constraints;
--drop table "Z09"."COURSE" cascade constraints;
--drop table "Z09"."EMPLOYEE" cascade constraints;
--drop table "Z09"."MAJOR" cascade constraints;
--drop table "Z09"."STUDENT_COURSE" cascade constraints;
--drop table "Z09"."COURSE_EMPLOYEE" cascade constraints;
--drop table "Z09"."RESERVATION" cascade constraints;
--drop table "Z09"."STUDENT" cascade constraints;





