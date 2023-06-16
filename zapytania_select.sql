--Liczba kursow przypisanych do prowadzacych
select e.employee_id, count(ce.course_id) as employee_courses_count
from employee e
join course_employee ce on(ce.employee_id = e.employee_id)
group by e.employee_id;

--Liczba kursow przypisanych do studentow
select s.name, s.student_id, count(sc.course_id) as student_courses_count
from student s
join student_course sc on(sc.student_id = s.student_id)
group by s.student_id, s.name;

--Suma miejsc siedzacych w budynku rosnaco
select b.name, sum(c.number_of_seats)
from building b
join classroom c on(b.building_id=c.building_id)
group by b.building_id, b.name
order by sum(c.number_of_seats) asc;

--Daty i godziny rozpoczecia i zakonczenia rezerwacji
select e.name, e.surname, c.name as course, TO_CHAR(r.res_start, 'HH24')||':'||TO_CHAR(r.res_start, 'MI') as start_hour, TO_CHAR(r.res_end, 'HH24')||':'||TO_CHAR(r.res_end, 'MI') as end_hour, r.res_start as date_of_res
from reservation r
join employee e using(employee_id)
join course c using (course_id)
join classroom cr using (classroom_id)
join building b on (b.building_id=cr.building_id);

--Liczba rezerwacji w zaleznosci od dnia
select TO_CHAR(res_start, 'YYYY/MM/DD') as date_of_res, count(reservation_id) as count_of_reservations
from reservation
group by TO_CHAR(res_start, 'YYYY/MM/DD')
order by TO_CHAR(res_start, 'YYYY/MM/DD') asc;

--Liczba osob na kierunku i srednia liczba ects u studentow na kierunku
select m.major_id, count(s.student_id) as count_of_students, COALESCE(AVG(s.ects_total), 0) AS avg_ects, m.semester*30 as ECTS_needed
from major m
left join student s on (s.major_id=m.major_id)
group by m.major_id, m.semester;

--Liczba uczonych studentow malejaco
select e.employee_id, e.name, e.surname, COUNT(sc.student_id) AS count_of_students
from employee e
left join course_employee ce ON e.employee_id = ce.employee_id
left join student_course sc ON ce.course_id = sc.course_id
left join student s ON sc.student_id = s.student_id
group by e.employee_id, e.name, e.surname
order by COUNT(sc.student_id) desc;

--Uznajac ze pierwsza cyfra w numerze klasy jest pietrem, dwie kolejne to numer pokoju, to znajdywane jest najwyzsze
--pietro na ktorym jest zarejestrowana klasa.
SELECT b.building_id, b.name, MAX(SUBSTR(c.classroom_number, 1, 1)) AS number_of_floors
FROM classroom c
JOIN building b ON c.building_id = b.building_id
GROUP BY b.building_id, b.name;


