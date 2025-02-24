create database subQueryEnum;

create table employees(
                          id serial primary key ,
                          first_name varchar,
                          last_name varchar,
                          email varchar,
                          salary int
);

insert into employees(first_name, last_name, email, salary)
values('Alice', 'Johnson', 'alice.johnson@example.com', 55000),
      ('Bob', 'Smith', 'bob.smith@example.com', 60000),
      ('Charlie', 'Brown', 'charlie.brown@example.com', 62000),
      ('David', 'Wilson', 'david.wilson@example.com', 58000),
      ('Emily', 'Davis', 'emily.davis@example.com', 61000),
      ('Frank', 'Miller', 'frank.miller@example.com', 53000),
      ('Grace', 'Taylor', 'grace.taylor@example.com', 65000),
      ('Henry', 'Anderson', 'henry.anderson@example.com', 70000),
      ('Ivy', 'Thomas', 'ivy.thomas@example.com', 68000),
      ('Jack', 'Moore', 'jack.moore@example.com', 72000),
      ('Karen', 'Martin', 'karen.martin@example.com', 54000),
      ('Leo', 'White', 'leo.white@example.com', 59000),
      ('Mia', 'Harris', 'mia.harris@example.com', 73000),
      ('Nathan', 'Clark', 'nathan.clark@example.com', 62000),
      ('Olivia', 'Rodriguez', 'olivia.rodriguez@example.com', 67000),
      ('Paul', 'Lewis', 'paul.lewis@example.com', 58000),
      ('Quinn', 'Walker', 'quinn.walker@example.com', 64000),
      ('Rachel', 'Hall', 'rachel.hall@example.com', 71000),
      ('Samuel', 'Allen', 'samuel.allen@example.com', 69000),
      ('Tina', 'Young', 'tina.young@example.com', 56000);

select * from employees;

select first_name,last_name,salary from employees where salary>71000;

select first_name,salary from employees where salary>(select salary from employees where first_name='Rachel');

create type countries as enum('KG','USA','Russia','KZ');

alter table employees add column country countries;

alter type countries add value 'UZ';

drop type countries cascade ;

alter table employees add column social_medias varchar[];

insert into employees(social_medias) values ('{facebook,instagram,whatsapp}');

select social_medias[2] from employees;
select employees.social_medias[3] from employees;
update employees set social_medias[2]='telegram';
select employees.social_medias[1:2] from employees;


create table publishers(
                           id serial primary key ,
                           name varchar
);

create table authors(
                        id serial primary key ,
                        first_name varchar,
                        last_name varchar,
                        email varchar,
                        date_of_birth date,
                        country varchar
);

create table languages(
                          id serial primary key ,
                          language varchar
);

create table books(
                      id serial primary key ,
                      name varchar,
                      country varchar,
                      published_year date,
                      price numeric,
                      language_id integer references languages(id),
                      published_id integer references publishers(id),
                      author_id integer references authors(id)
);

-- Publishers маалыматтарын кошуу
INSERT INTO publishers (name) VALUES
                                  ('Penguin Random House'),
                                  ('HarperCollins'),
                                  ('Simon & Schuster'),
                                  ('Macmillan Publishers'),
                                  ('Hachette Book Group');

-- Authors (Ар кайсы өлкөдөн келген жазуучулар)
INSERT INTO authors (first_name, last_name, email, date_of_birth, country) VALUES
                                                                               ('George', 'Orwell', 'orwell@example.com', '1903-06-25', 'United Kingdom'),
                                                                               ('Jane', 'Austen', 'jane.austen@example.com', '1775-12-16', 'United Kingdom'),
                                                                               ('Mark', 'Twain', 'mark.twain@example.com', '1835-11-30', 'United States'),
                                                                               ('J.K.', 'Rowling', 'jk.rowling@example.com', '1965-07-31', 'United Kingdom'),
                                                                               ('Ernest', 'Hemingway', 'ernest.hemingway@example.com', '1899-07-21', 'United States'),
                                                                               ('Leo', 'Tolstoy', 'leo.tolstoy@example.com', '1828-09-09', 'Russia'),
                                                                               ('Fyodor', 'Dostoevsky', 'dostoevsky@example.com', '1821-11-11', 'Russia'),
                                                                               ('Gabriel', 'Garcia Marquez', 'marquez@example.com', '1927-03-06', 'Colombia'),
                                                                               ('Victor', 'Hugo', 'victor.hugo@example.com', '1802-02-26', 'France'),
                                                                               ('Miguel', 'de Cervantes', 'cervantes@example.com', '1547-09-29', 'Spain'),
                                                                               ('Alexandre', 'Dumas', 'dumas@example.com', '1802-07-24', 'France'),
                                                                               ('Paulo', 'Coelho', 'paulo.coelho@example.com', '1947-08-24', 'Brazil'),
                                                                               ('Haruki', 'Murakami', 'murakami@example.com', '1949-01-12', 'Japan'),
                                                                               ('Franz', 'Kafka', 'kafka@example.com', '1883-07-03', 'Czech Republic'),
                                                                               ('Bram', 'Stoker', 'bram.stoker@example.com', '1847-11-08', 'Ireland');

-- Languages маалыматтарын кошуу
INSERT INTO languages (language) VALUES
                                     ('English'),
                                     ('Spanish'),
                                     ('French'),
                                     ('German'),
                                     ('Russian'),
                                     ('Japanese');

-- Books маалыматтарын кошуу (50 жазуу)

INSERT INTO books (name, country, published_year, price, language_id, published_id, author_id) VALUES
                                                                                                   ('1984', 'United Kingdom', '1949-06-08', 15.99, 1, 1, 1),
                                                                                                   ('Animal Farm', 'United Kingdom', '1945-08-17', 12.99, 1, 1, 1),
                                                                                                   ('Pride and Prejudice', 'United Kingdom', '1813-01-28', 14.99, 1, 2, 2),
                                                                                                   ('Emma', 'United Kingdom', '1815-12-23', 13.99, 1, 2, 2),
                                                                                                   ('Adventures of Huckleberry Finn', 'United States', '1885-12-10', 18.50, 1, 3, 3),
                                                                                                   ('Harry Potter and the Philosopher''s Stone', 'United Kingdom', '1997-06-26', 20.99, 1, 4, 4),
                                                                                                   ('The Old Man and the Sea', 'United States', '1952-09-01', 17.99, 1, 5, 5),
                                                                                                   ('War and Peace', 'Russia', '1869-01-01', 29.99, 5, 2, 6),
                                                                                                   ('Crime and Punishment', 'Russia', '1866-01-01', 25.99, 5, 2, 7),
                                                                                                   ('One Hundred Years of Solitude', 'Colombia', '1967-05-30', 24.99, 2, 1, 8),
                                                                                                   ('Les Misérables', 'France', '1862-01-01', 26.50, 3, 2, 9),
                                                                                                   ('The Count of Monte Cristo', 'France', '1844-01-01', 27.99, 3, 2, 10),
                                                                                                   ('Don Quixote', 'Spain', '1605-01-16', 23.99, 2, 1, 10),
                                                                                                   ('The Alchemist', 'Brazil', '1988-01-01', 19.99, 2, 1, 12),
                                                                                                   ('Kafka on the Shore', 'Japan', '2002-09-12', 21.50, 6, 3, 13),
                                                                                                   ('The Trial', 'Czech Republic', '1925-01-01', 22.99, 3, 3, 14),
                                                                                                   ('Dracula', 'Ireland', '1897-05-26', 21.99, 1, 5, 15),
                                                                                                   ('Frankenstein', 'United Kingdom', '1818-01-01', 23.99, 1, 5, 2),
                                                                                                   ('The Picture of Dorian Gray', 'United Kingdom', '1890-06-20', 22.50, 1, 5, 2),
                                                                                                   ('To Kill a Mockingbird', 'United States', '1960-07-11', 22.50, 1, 3, 3),
                                                                                                   ('The Great Gatsby', 'United States', '1925-04-10', 19.99, 1, 3, 3),
                                                                                                   ('The Three Musketeers', 'France', '1844-01-01', 22.50, 3, 2, 10),
                                                                                                   ('Germinal', 'France', '1885-01-01', 24.99, 3, 2, 9),
                                                                                                   ('Brave New World', 'United Kingdom', '1932-01-01', 18.99, 1, 5, 1),
                                                                                                   ('Lord of the Flies', 'United Kingdom', '1954-09-17', 20.50, 1, 5, 1),
                                                                                                   ('The Hobbit', 'United Kingdom', '1937-09-21', 22.99, 1, 4, 4),
                                                                                                   ('The Lord of the Rings', 'United Kingdom', '1954-07-29', 29.99, 1, 4, 4),
                                                                                                   ('The Little Prince', 'France', '1943-04-06', 16.50, 3, 2, 9),
                                                                                                   ('A Farewell to Arms', 'United States', '1929-09-27', 16.99, 1, 5, 5),
                                                                                                   ('The Sun Also Rises', 'United States', '1926-10-22', 18.25, 1, 5, 5),
                                                                                                   ('A Tale of Two Cities', 'United Kingdom', '1859-01-01', 20.99, 1, 5, 2),
                                                                                                   ('Great Expectations', 'United Kingdom', '1861-01-01', 22.99, 1, 5, 2),
                                                                                                   ('David Copperfield', 'United Kingdom', '1850-01-01', 23.99, 1, 5, 2);

--1.Авторлордун атын, почтасын жана мамлекетин чыгарып бериниз
select first_name,email,country from authors;
--2. 2020-2023- жж. аралыгында чыккан китептерди чыгарыныз
select name,published_year from books where published_year between '1926-01-01' and '1943-01-01';
--3. Германия жана Франциялык гана авторлордун атын, фамилиясын бир колонкага full_name деп сорттоп чыгарыныз(олкосунун аты да чыксын)
select concat(first_name,' ',last_name) as full_name,country from authors where country in ('France', 'Russia') order by full_name;
--4 Бардык олколорду жана ар бир олкодо канчадан автор бар экенин чыгарыныз
select country,count(authors) as author_count from authors group by country ;
--5. Эки же экиден аз автор бар болгон олколорду аты менен сорттоп чыгарыныз
select country,first_name from authors group by country,first_name having count(id)<=2 order by country;
--Китептин аты, басмакананы аты жана китептин кайсы тилде экенин чыгарыныз
select b.name,p.name,language from books b join publishers p on b.published_id = p.id join languages l on b.language_id = l.id;
--Китептердин аттары,чыккан олкосу, авторлордун аты, фамилиясы жана издательстволору чыксын.
--китеби жок издательство болсо аты чыгып, маалыматтарына null чыксын
select b.name,b.country,a.first_name,a.last_name,p.name from books b join authors a on a.id = b.author_id right join publishers p on p.id = b.published_id;
--Авторлордун толук аты-жону (author_name деп бир колонкага) жана китептери чыксын. Китеби жок болсо null чыксын.
select concat(first_name,' ',last_name) as author_name, name from books b right join authors a on a.id = b.author_id;
--Кайсы тилде канча китеп бар экендиги ылдыйдан ойдого сорттолуп чыксын.
select language, count(b.id) as books_count  from books b join languages l on l.id = b.language_id group by language order by books_count ;
--10. Издательствонун аттары жана алардын тапкан акчасынын жалпы суммасы тегеректелип чыгарылсын.
select p.name, round(sum(b.price)) as book_price from publishers p left join books b on p.id = b.published_id group by p.name order by book_price;