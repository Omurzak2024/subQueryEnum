create database publishers;

-- Создание ENUM для пола
CREATE TYPE gender AS ENUM ('Male', 'Female');

-- Создание ENUM для жанров
CREATE TYPE genre AS ENUM ('Detective', 'Fantasy', 'Drama', 'Romance', 'History', 'Biography');

-- Таблица издателей
CREATE TABLE publishers (
                            id SERIAL PRIMARY KEY,
                            name VARCHAR NOT NULL
);

-- Таблица авторов
CREATE TABLE authors (
                         id SERIAL PRIMARY KEY,
                         first_name VARCHAR NOT NULL,
                         last_name VARCHAR NOT NULL,
                         email VARCHAR UNIQUE NOT NULL,
                         date_of_birth DATE NOT NULL,
                         country VARCHAR NOT NULL,
                         gender gender NOT NULL
);

-- Таблица языков
CREATE TABLE languages (
                           id SERIAL PRIMARY KEY,
                           language VARCHAR UNIQUE NOT NULL
);

-- Таблица книг
CREATE TABLE books (
                       id SERIAL PRIMARY KEY,
                       name VARCHAR NOT NULL,
                       country VARCHAR NOT NULL,
                       published_year DATE NOT NULL,
                       price INT CHECK (price > 0),
                       genre genre NOT NULL,
                       language_id INT REFERENCES languages(id) ON DELETE CASCADE,
                       publisher_id INT REFERENCES publishers(id) ON DELETE CASCADE,
                       author_id INT REFERENCES authors(id) ON DELETE CASCADE
);

-- Вставка данных в таблицу publishers
INSERT INTO publishers(name)
VALUES ('RELX Group'),
       ('Thomson Reuters'),
       ('Holtzbrinck Publishing Group'),
       ('Shanghai Jiao Tong University Press'),
       ('Wolters Kluwer'),
       ('Hachette Livre'),
       ('Aufbau-Verlag'),
       ('Macmillan'),
       ('Harper Collins'),
       ('China Publishing Group'),
       ('Springer Nature'),
       ('Grupo Planeta'),
       ('Books.Ru Ltd.St Petersburg'),
       ('The Moscow Times'),
       ('Zhonghua Book Company');

-- Вставка данных в таблицу authors
INSERT INTO authors(first_name, last_name, email, date_of_birth, country, gender)
VALUES ('Sybilla', 'Toderbrugge', 'stoderbrugge0@jugem.jp', '1968-09-25', 'France', 'Female'),
       ('Patti', 'Walster', 'pwalster1@addtoany.com', '1965-10-31', 'China', 'Female'),
       ('Sonnie', 'Emmens', 'semmens2@upenn.edu', '1980-05-16', 'Germany', 'Male'),
       ('Brand', 'Burel', 'bburel3@ovh.net', '1964-04-24', 'United States', 'Male'),
       ('Silvan', 'Smartman', 'ssmartman4@spiegel.de', '1967-07-03', 'France', 'Male'),
       ('Alexey', 'Arnov', 'larnoldi5@writer.com', '1964-12-29', 'Russia', 'Male'),
       ('Bunni', 'Aggio', 'baggio6@yahoo.co.jp', '1983-12-14', 'China', 'Female'),
       ('Viole', 'Sarath', 'vsarath7@elegantthemes.com', '1960-01-29', 'United States', 'Female'),
       ('Boigie', 'Etridge', 'betridge8@ed.gov', '1978-11-17', 'France', 'Male'),
       ('Hilliard', 'Burnsyde', 'hburnsyde9@omniture.com', '1962-09-08', 'Germany', 'Male'),
       ('Margarita', 'Bartova', 'mbartova@example.com', '1984-12-03', 'Russia', 'Female'),
       ('Innis', 'Hugh', 'ihughb@marriott.com', '1983-08-28', 'Germany', 'Male'),
       ('Lera', 'Trimnella', 'ltrimnellc@msn.com', '1980-03-28', 'Russia', 'Female'),
       ('Jakob', 'Bransby', 'jbransbyd@nasa.gov', '1966-08-05', 'Spain', 'Male'),
       ('Loretta', 'Gronaver', 'lgronavere@technorati.com', '1962-10-17', 'United States', 'Female');

-- Вставка данных в таблицу languages
INSERT INTO languages(language)
VALUES ('English'),
       ('French'),
       ('German'),
       ('Chinese'),
       ('Russian'),
       ('Spanish');

-- Вставка данных в таблицу books
INSERT INTO books(name, country, published_year, price, genre, language_id, publisher_id, author_id)
VALUES ('Taina', 'Russia', '2021-11-12', 568, 'Detective', 5, 12, 6),
       ('Zvezdopad', 'Russia', '2004-12-09', 446, 'Romance', 5, 13, 11),
       ('Homo Faber', 'Germany', '2022-04-10', 772, 'Fantasy', 3, 5, 3),
       ('Der Richter und Sein Henker', 'Germany', '2011-02-01', 780, 'Detective', 3, 3, 10),
       ('Lord of the Flies', 'United States', '2015-07-11', 900, 'Fantasy', 1, 2, 4),
       ('Un soir au club', 'France', '2018-01-12', 480, 'Drama', 2, 1, 1),
       ('Voina', 'Russia', '2004-12-06', 880, 'History', 5, 4, 13),
       ('Sun Tzu', 'China', '2022-09-05', 349, 'History', 4, 4, 2),
       ('Emil und die Detektive', 'Germany', '2010-06-11', 228, 'Detective', 3, 5, 10),
       ('The Fault in Our Stars', 'United States', '2008-02-13', 396, 'Romance', 1, 9, 4),
       ('Die R uber', 'Germany', '2020-06-25', 300, 'Romance', 3, 7, 12),
       ('Les Aventures de Tintin', 'France', '2015-04-10', 582, 'Drama', 2, 1, 5),
       ('Jung Chang', 'China', '2021-05-14', 600, 'History', 4, 10, 7),
       ('Krasnaya luna', 'Russia', '2020-02-07', 550, 'Fantasy', 5, 12, 11),
       ('Emma', 'United States', '2021-10-11', 599, 'Biography', 1, 2, 15);


--Запросы:
--1.Китептердин атын, чыккан жылын, жанрын чыгарыныз.
select name,published_year,genre from books;
--2.Авторлордун мамлекеттери уникалдуу чыксын.
select distinct country from authors order by country;
--3.2020-2023 жылдардын арасындагы китептер чыксын.
select name,published_year from books where published_year between '2020-01-01' and '2023-01-01';
--4.Детектив китептер жана алардын аттары чыксын.
select genre,name from books where genre='Detective';
--5.Автордун аты-жону author деген бир колонкага чыксын.
select concat(first_name,' ',last_name) as author from authors;
--6.Германия жана Франциядан болгон авторлорду толук аты-жону менен сорттоп чыгарыныз.
select country,concat(first_name,' ',last_name) as full_name from authors where country in ('Germany','France') order by full_name;
--7.Романдан башка жана баасы 500 дон кичине болгон китептердин аты, олкосу, чыккан жылы, баасы жанры чыксын..
select name,country,published_year,price,genre from books where genre!='Romance' and price<500;
--8.Бардык кыз авторлордун биринчи 3 ну чыгарыныз.
select * from authors where gender='Female' order by date_of_birth limit 3;
--9.Почтасы .com мн буткон, аты 4 тамгадан турган, кыз авторлорду чыгарыныз.
select * from authors where length(first_name)=4 and email like '%.com' and gender='Female';
--10.Бардык олколорду жана ар бир олкодо канчадан автор бар экенин чыгаргыла.
select country,count(id) as author_count from authors group by country ;
--11.Уч автор бар болгон олколорду аты мн сорттоп чыгарыныз.
select country,count(*) as author_count from authors group by country having count(*)=3 order by country;
--12. Ар бир жанрдагы китептердин жалпы суммасын чыгарыныз
select genre,sum(price) as total_price from books group by genre ;
--13. Роман жана Детектив китептеринин эн арзан бааларын чыгарыныз
select genre,price from books where genre in ('Romance','Detective') order by price limit 2;
select genre,min(price) as min_price from books where genre in ('Romance', 'Detective') group by genre ;
--14.История жана Биографиялык китептердин сандарын чыгарыныз
select genre,count(*) as book_count from books where genre in ('History','Biography') group by genre ;
--15.Китептердин , издательстволордун аттары жана тили чыксын
select b.name,p.name,language from books b join publishers p on p.id = b.publisher_id join languages l on l.id=b.language_id;
--156Авторлордун бардык маалыматтары жана издательстволору чыксын, издательство болбосо null чыксын
select first_name,last_name,date_of_birth,gender,email,p.name from authors a left join books b on a.id = b.author_id left join publishers p on p.id = b.publisher_id;
--17.Авторлордун толук аты-жону жана китептери чыксын, китеби жок болсо null чыксын.
select concat(first_name,' ',last_name) as full_name, name from authors a left join books b on a.id = b.author_id;
--18.Кайсы тилде канча китеп бар экендиги ылдыйдан ойлдого сорттолуп чыксын.
select language,count(*) as book_count  from books b join languages l on l.id = b.language_id group by language order by book_count;
--19.Издательствонун аттары жана алардын тапкан акчасынын орточо суммасы тегеректелип чыгарылсын.
select p.name,round(avg(b.price),2) as total_price from publishers p join books b on p.id = b.publisher_id group by p.name ;
SELECT
    p.name AS publisher_name,
    ROUND(AVG(b.price), 2) AS avg_price
FROM publishers p
         JOIN books b ON p.id = b.publisher_id
GROUP BY p.name
ORDER BY avg_price DESC;

--20.2010-2015 жылдардын арасындагы китептер жана автордун аты-фамилиясы чыксын.
select first_name,last_name,name,published_year from authors a left join books b on a.id = b.author_id where published_year between '2010-01-01' and '2015-12-30' order by published_year;
--21.2010-2015 жылдардын арасындагы китептердин авторлорунун толук аты-жону жана алардын тапкан акчаларынын жалпы суммасы чыксын.
select concat(first_name,' ',last_name) as full_name,sum(price) as total_price from authors a join books b on a.id = b.author_id where published_year between '2010-01-01' and '2015-12-30' group by full_name;
