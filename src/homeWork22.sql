create type gender as enum('Male','Female');
create type specialization as enum(
    'Dermotologist',
    'Cardiologist',
    'Allergist',
    'Ortopedist',
    'Psychiatrist'
    );

create table hospitals(
                          id serial primary key ,
                          name varchar not null ,
                          address varchar not null
);

create table departments(
                            id serial primary key ,
                            department_name varchar not null ,
                            hospital_id integer references hospitals(id) on delete cascade
);

create table doctors(
                        id serial primary key ,
                        first_name varchar not null ,
                        last_name varchar not null ,
                        experience int not null ,
                        email varchar,
                        gender gender not null ,
                        specialization varchar not null ,
                        department_id integer references departments(id) on DELETE cascade
);



create table patients(
                         id serial primary key ,
                         first_name varchar not null ,
                         last_name varchar not null ,
                         phone_number varchar,
                         email varchar,
                         gender gender not null ,
                         hospital_id integer references hospitals(id) on delete cascade ,
                         doctor_id integer references doctors(id) on delete cascade
);

INSERT INTO hospitals (name, address) VALUES
                                          ('City Hospital', '123 Main St, New York'),
                                          ('Grand Medical Center', '45 Elm St, Los Angeles'),
                                          ('Central Clinic', '78 Maple Ave, Chicago'),
                                          ('Sunrise Hospital', '90 Pine Rd, Houston'),
                                          ('Green Valley Hospital', '120 Oak St, San Francisco');

INSERT INTO departments (department_name, hospital_id) VALUES
                                                           ('Surgical', 1),
                                                           ('Intensive', 1),
                                                           ('Neurology', 2),
                                                           ('Cardiology', 2),
                                                           ('Orthopedics', 3),
                                                           ('Psychiatry', 3),
                                                           ('Dermatology', 4),
                                                           ('General Medicine', 5);

INSERT INTO doctors (first_name, last_name, experience, email, gender, specialization, department_id) VALUES
                                                                                                          ('John', 'Doe', 15, 'johndoe@example.com', 'Male', 'Cardiologist', 4),
                                                                                                          ('Anna', 'Smith', 8, 'annasmith@example.com', 'Female', 'Dermotologist', 7),
                                                                                                          ('Michael', 'Brown', 5, 'michaelbrown@example.com', 'Male', 'Allergist', 8),
                                                                                                          ('Sarah', 'Johnson', 12, 'sarahjohnson@example.com', 'Female', 'Ortopedist', 5),
                                                                                                          ('David', 'Wilson', 20, 'davidwilson@example.com', 'Male', 'Psychiatrist', 6),
                                                                                                          ('Emily', 'Clark', 3, 'emilyclark@example.com', 'Female', 'Cardiologist', 4),
                                                                                                          ('James', 'Davis', 6, 'jamesdavis@example.com', 'Male', 'Dermotologist', 7),
                                                                                                          ('Laura', 'Miller', 10, 'lauramiller@example.com', 'Female', 'Surgical', 1),
                                                                                                          ('Robert', 'Martinez', 7, 'robertmartinez@example.com', 'Male', 'Intensive', 2),
                                                                                                          ('Sophia', 'Lopez', 4, 'sophialopez@example.com', 'Female', 'Intensive', 2);

INSERT INTO patients (first_name, last_name, phone_number, email, gender, hospital_id, doctor_id) VALUES
                                                                                                      ('Alice', 'Williams', '555-1234', 'alicew@example.com', 'Female', 1, 8),
                                                                                                      ('Bob', 'Johnson', '555-5678', 'bobj@example.com', 'Male', 1, 8),
                                                                                                      ('Charlie', 'Smith', '555-8765', 'charlies@example.com', 'Male', 1, 9),
                                                                                                      ('Diana', 'Brown', '555-4321', 'dianab@example.com', 'Female', 2, 9),
                                                                                                      ('Ethan', 'White', '555-3456', 'ethanw@example.com', 'Male', 2, 10),
                                                                                                      ('Fiona', 'Harris', '555-7890', 'fionah@example.com', 'Female', 3, 4),
                                                                                                      ('George', 'Anderson', '555-6543', 'georgea@example.com', 'Male', 3, 4),
                                                                                                      ('Hannah', 'Lee', '555-2345', 'hannahl@example.com', 'Female', 4, 5),
                                                                                                      ('Isaac', 'Moore', '555-8769', 'isaacm@example.com', 'Male', 4, 5),
                                                                                                      ('Julia', 'Taylor', '555-2134', 'juliat@example.com', 'Female', 5, 6),
                                                                                                      ('Kevin', 'Martin', '555-6789', 'kevinm@example.com', 'Male', 5, 7),
                                                                                                      ('Liam', 'Hall', '555-9087', 'liamh@example.com', 'Male', 5, 7),
                                                                                                      ('Mia', 'Baker', '555-5432', 'miab@example.com', 'Female', 1, NULL), -- Дарыгери жок пациент
                                                                                                      ('Nathan', 'Adams', '555-4329', 'nathana@example.com', 'Male', 2, NULL); -- Дарыгери жок пациент


--1. 'Surgical' бөлүмүндө дарыланып жаткан бардык пациенттерди табуу
select * from patients p
where doctor_id in (select d.id from doctors d
                    where department_id in
                          (select d2.id from departments d2 where department_name='Surgical'));
SELECT *
FROM patients
WHERE doctor_id IN (
    SELECT d.id
    FROM doctors d
             JOIN departments dep ON d.department_id = dep.id
    WHERE dep.department_name IN ('Surgical', 'Intensive')
);

--2. 'John' аттуу дарыгер иштеген бардык бөлүмдөрдүн тизмесин алуу
select * from departments d where d.id in (select doctors.department_id from doctors where first_name='John');

--3. Дарыгеринин тажрыйбасы 10 жылдан ашкан бардык пациенттерди табуу
select * from patients p where p.doctor_id in (select d.id from doctors d where experience>10);
--4. Бардык дарыгерлердин жана алардын тейлеген пациенттеринин санын алуу
select concat(d.first_name,' ',d.last_name) as full_name,count(p.id) as patient_count from doctors d
                                                                                               join patients p on d.id = p.doctor_id group by full_name;
select first_name,count(*) from doctors d where d.id in (select p.doctor_id from patients p) group by first_name ;
--5. Эч бир дарыгер тейлебеген бардык пациенттердин тизмесин алуу
select * from doctors d right join patients p on d.id = p.doctor_id;
select * from patients where doctor_id is null ;
select * from patients p left join doctors d on d.id = p.doctor_id where doctor_id is null ;
--6. Эч бир пациентти тейлебеген дарыгерлердин тизмесин алуу
select * from doctors d left join patients p on d.id = p.doctor_id where doctor_id is null ;
select d.first_name,d.last_name,doctor_id from doctors d left join patients p on d.id = p.doctor_id where doctor_id is null ;
--7. 60 жаштан жогору пациенттерди дарылоочу бардык дарыгерлердин тизмесин алуу
SELECT DISTINCT d.id, d.first_name, d.last_name, d.specialization
FROM doctors d
         JOIN patients p ON d.id = p.doctor_id
WHERE p.date_of_birth <= CURRENT_DATE - INTERVAL '60 years';
--8. 'Anna' аттуу жана 'Smith' фамилиялуу дарыгерден дарыланып жаткан бардык пациенттерди табуу
select p.id, p.first_name, p.last_name, p.phone_number, p.email, p.gender from patients p
                                                                                   join doctors d on d.id = p.doctor_id where d.first_name='Anna' and d.last_name='Smith';

SELECT *
FROM patients
WHERE doctor_id = (
    SELECT id
    FROM doctors
    WHERE first_name = 'Anna' AND last_name = 'Smith'
);

--9. 'Intensive' бөлүмүндө иштеген жана 3төн көп пациентти тейлеген бардык дарыгерлердин тизмесин алуу
select d.id, d.first_name, d.last_name, d.experience, d.email, d.gender, d.specialization from doctors d
                                                                                                   join departments d2 on d.department_id = d2.id
                                                                                                   join patients p on d.id = p.doctor_id
where department_name='Intensive'
group by d.id, d.first_name, d.last_name, d.experience, d.email, d.gender, d.specialization
having count(p.id)>3;
SELECT d.id, d.first_name, d.last_name, d.experience, d.email, d.gender, d.specialization
FROM doctors d
         JOIN departments dep ON d.department_id = dep.id
         JOIN patients p ON d.id = p.doctor_id
WHERE dep.department_name = 'Intensive'
GROUP BY d.id, d.first_name, d.last_name, d.experience, d.email, d.gender, d.specialization
HAVING COUNT(p.id) > 3;

SELECT *
FROM doctors
WHERE id IN (
    SELECT doctor_id
    FROM patients
    WHERE doctor_id IN (
        SELECT d.id
        FROM doctors d
                 JOIN departments dep ON d.department_id = dep.id
        WHERE dep.department_name = 'Intensive'
    )
    GROUP BY doctor_id
    HAVING COUNT(*) > 3
);


--10. Тажрыйбасы 5 жылдан аз болгон дарыгерлер пациенттерди дарылоочу бөлүмдөрдүн тизмесин алуу
select department_name,d2.first_name,experience from departments d join doctors d2 on d.id = d2.department_id join patients p on d2.id = p.doctor_id where experience<5;
--11. 'DERMOTOLOGIST' адистигине ээ болгон дарыгерден дарыланып жаткан бардык пациенттерди табуу
select p.first_name,p.last_name,specialization from patients p join doctors d on d.id = p.doctor_id where specialization='Dermotologist';
--12. Ар бир адистик боюнча дарыгерлердин санын алуу
select specialization,count(*) from doctors group by specialization ;
--13. Эң аз кездешкен адистикке ээ болгон дарыгерлер тейлеген бардык пациенттерди табуу
WITH specialization_counts AS (
    SELECT specialization, COUNT(*) AS doctor_count
    FROM doctors
    GROUP BY specialization
    ORDER BY doctor_count ASC
    LIMIT 1
)
SELECT p.*
FROM patients p
         JOIN doctors d ON p.doctor_id = d.id
WHERE d.specialization = (SELECT specialization FROM specialization_counts);

SELECT *
FROM patients
WHERE doctor_id IN (
    SELECT id
    FROM doctors
    WHERE specialization = (
        SELECT specialization
        FROM doctors
        GROUP BY specialization
        ORDER BY COUNT(*) ASC
        LIMIT 1
    )
);


--14. 'CARDIOLOGIST' адистиги бар дарыгер тейлеген бардык пациенттерди табуу
select * from patients p join doctors d on d.id = p.doctor_id where specialization='Cardiologist';
--15. 'Neurology' бөлүмүндө иштеген жана 3төн көп пациентти тейлеген бардык дарыгерлердин тизмесин алуу
select d.* from doctors d
                    join departments d2 on d2.id = d.department_id
                    join patients p on d.id = p.doctor_id
where department_name='Neurology'
group by d.id
having count(p.id)>3;

SELECT *
FROM doctors
WHERE id IN (
    SELECT doctor_id
    FROM patients
    WHERE doctor_id IN (
        SELECT d.id
        FROM doctors d
                 JOIN departments dep ON d.department_id = dep.id
        WHERE dep.department_name = 'Neurology'
    )
    GROUP BY doctor_id
    HAVING COUNT(*) > 3
);






