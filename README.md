	Opis Projektu

Celem tego projektu jest stworzenie bazy danych dla szkoły/uczelni do zarządzania rezerwacjami sal w ramach przedmiotów. Baza danych 
będzie gromadziła informacje na temat budynków, pracowników, studentów, sal lekcyjnych, kursów oraz rezerwacji. Projekt składa się z 
dziesięciu tabel.
Tabele:
 - Tabela address zawiera informacje na temat adresów poszczególnych budynków szkoły. Każdy rekord składa się z 
   unikalnego address_id, street, postal_code, city, oraz building_id, które jest kluczem obcym odnoszącym się do tabeli building.

 - Tabela building przechowuje informacje na temat poszczególnych budynków szkoły. Każdy budynek jest jednoznacznie 
   identyfikowany za pomocą building_id i przypisaną nazwą name.

 - Tabela classroom gromadzi informacje na temat sal lekcyjnych w poszczególnych budynkach. Każda sala ma unikalne 
   classroom_id, numer sali classroom_number, status dostępności available, identyfikator budynku building_id i liczbę miejsc number_of_seats.

 - Tabela course zawiera informacje o kursach oferowanych przez szkołę. Każdy kurs ma unikalny course_id i name oraz 
   określoną liczbę punktów ECTS (ects).

 - Tabela course_employee stanowi relację między kursem a pracownikami - określa, który pracownik jest odpowiedzialny 
   za dany kurs. Każdy rekord składa się z employee_id i course_id.

 - Tabela employee gromadzi informacje o pracownikach szkoły. Każdy pracownik jest jednoznacznie identyfikowany za 
   pomocą employee_id oraz ma przypisane name i surname.

 - Tabela major zawiera informacje o kierunkach studiów. Każdy kierunek ma unikalne major_id, name i semester.

 - Tabela reservation zawiera informacje o rezerwacjach sal. Każda rezerwacja ma unikalne reservation_id, 
   res_start (data i godzina rozpoczęcia), res_end (data i godzina zakończenia), employee_id, course_id i classroom_id.

 - Tabela student przechowuje informacje o studentach. Każdy student ma unikalne student_id, name, surname i major_id.

 - Tabela student_course stanowi relację między studentami a kursami - określa, którego kursu student jest zapisany. 
   Każdy rekord składa się z student_id i course_id.

Projekt zapewnia integralność danych poprzez użycie kluczy obcych. Dla przykładu, building_id w tabeli address musi być 
wartością, która istnieje w tabeli building. Podobnie, classroom_id w tabeli reservation musi istnieć w tabeli classroom.

-----------------------------------------------------------------------------------------------------------------------------------------------
	Analiza Krytyczna Rozwiązania

   Podczas analizowania projektu, można zauważyć pewne mocne i słabe strony.
   Na plus zdecydowanie działa dobrze zaprojektowany schemat relacyjny. Klucze obce są stosowane tam, gdzie jest to konieczne, 
aby zapewnić integralność danych. Stosowanie unikalnych identyfikatorów dla każdej z tabel pomaga w jednoznacznym identyfikowaniu rekordów.
   Jednak brak jest tabeli, która gromadziłaby informacje na temat zajęc prowadzonych w ramach przedmiotów. Informacjami takimi 
mógłby być np typ zajęc - laboratoria, ćwiczenia lub wykłady. Można by było rozważyć dodanie większej liczby pól w tabelach dotyczących 
pracowników i studentów, takich jak adres e-mail, numer telefonu, daty zatrudnienia/zapisania się na studia, itp. Mogłoby to pomóc 
w lepszym zarządzaniu tymi grupami użytkowników. Ograniczenia te wynikają jednak z zamysłu projektu jakim jest stworzenie podstawowego 
sysytemu obsługi rezerwacji, który można dalej rozwijać. Projekt stanowi solidną bazę dla systemu zarządzania rezerwacjami.

-----------------------------------------------------------------------------------------------------------------------------------------------
	Funkcje, Wyzsalacze, Procedury i Kursory

Wyzwalacze:
1. Wyzwalacz check_class              : podnosi błąd jeżeli liczba uczestniczących uczniów na rezerwowanych zajęciach będzie większa niż liczba miejsc w klasie, albo kiedy klasa jest niedostępna do użytku (available='N').
2. Wyzwalacz check_reservation_timing : podnosi błąd jeżeli nowa albo edytowana rezerwacja nakłada się datą, godziną i klasą z inną rezerwacją.
Procedury(w procedurach użyte kursory):
1. Procedura reservations             : wyświetli po kolei (od najbliższych zajęć) n zajęć odbywających się w danej sali, prowadzącego, przedmiot, datę i godzinę | Przyjmue - numer sali, budynek i liczbę rezerwacji n do wyświetlenia.
2. Procedura student_classes          : informuje studenta o jego najbliższych zajęciach, gdzie się odbywaja oraz kto je prowadzi.| Przyjmuje - id studenta
Funkcje:
1. Funkcja punkty_ECTS                : zwraca informację dla studenta, ile w sumie punktów ECTS robi w aktualnym semestrze, ile brakuje/jest w nadmiarze pkt ECTS do zaliczenia semestru | Przyjmuje - id studenta
2. Funkcja amount_of_students         : zwracająca liczbę studentów którzy będą uczestniczyć na zajęciach (są zapisani na dany kurs) | Przyjmuje - id kursu
