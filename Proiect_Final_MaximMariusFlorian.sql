create database Game_Stores;  -- We create a database and select it --
use Game_Stores;  

-- First table when data regarding our stores is present --

create table stores(
Store_ID int primary key auto_increment,
Store_Name varchar(100) NOT NULL,
rating real);

select * from stores; -- We verify that the  table was created --
insert into stores (Store_Name, rating) values ("Steam",10), ("Epic Games",6), ("GOG",8), ("GameStop", 6.5), ("EMAG", 7); -- Added values to the table --

create table games(
id int primary key auto_increment,
store_id int,
Name varchar(100) NOT NULL,
Genre varchar(50),
rating real,
price real,
physical_copy varchar(10) NOT NULL,
constraint foreign key(store_id) references stores(Store_ID)
);

select * from games; -- We verify that the the table was created --

-- We add games to our stores --
insert into games (store_id, Name, Genre, rating, price, physical_copy) values 
(1, "FalloutNewVegas", "Action", 10, 5.99, "NO"),
(1, "AgeOfEmpires", "Strategy", 6, 10.99, "YES"),
(1, "EAFC24", "Sports", 3, 25.99, "YES"),
(1, "GhostWarrior", "Drama", 8.99, 15.99, "NO");

insert into games (store_id, Name, Genre, rating, price, physical_copy) values 
(2, "Fallout4", "Action", 8, 6.99, "NO"),
(2, "FalloutNewVegas", "RPG", 10, 10.99, "YES"),
(2, "Fortnite", "Action", 5.44, 12.00, "YES"),
(2, "ResidentEvil3", "Horror", 8.55, 12.25, "NO");

insert into games (store_id, Name, Genre, rating, price, physical_copy) values 
(3, "Fallout4", "Action", 8, 6.99, "NO"),
(3, "FalloutNewVegas", "RPG", 10, 10.99, "YES"),
(3, "Fortnite", "Action", 5.44, 12.00, "YES"),
(3, "ResidentEvil3", "Horror", 8.55, 12.25, "NO"),
(3, "WoW", "MMORP", 7.50, 60.99, "YES");

insert into games (store_id, Name, Genre, rating, price, physical_copy) values 
(4, "Fallout4", "Action", 8, 6.99, "YES"),
(4, "FalloutNewVegas", "RPG", 10, 10.99, "YES"),
(4, "Fortnite", "Action", 5.44, 12.00, "YES"),
(4, "ResidentEvil3", "Horror", 8.55, 12.25, "YES"),
(4, "WoW", "MMORP", 7.50, 60.99, "YES"),
(4, "Genshin", "RPG", 8, 50.99, "YES"),
(4, "Fallout3", "RPG", 9, 12.99, "YES");

insert into games (store_id, Name, Genre, rating, price, physical_copy) values
(5, "Fallout4", "Action", 8, 6.99, "YES"),
(5, "FalloutNewVegas", "RPG", 10, 10.99, "YES"),
(5, "Fortnite", "Action", 5.44, 12.00, "YES"),
(5, "ResidentEvil3", "Horror", 8.55, 12.25, "YES"),
(5, "WoW", "MMORP", 7.50, 60.99, "YES"),
(5, "Genshin", "RPG", 8, 50.99, "YES"),
(5, "Fallout3", "RPG", 9, 12.99, "YES");

SELECT * FROM games
WHERE physical_copy IN ('YES'); -- We check to see the total of games that also have a physical copy option and their store id --

SELECT * FROM games
WHERE price BETWEEN 10 AND 25; -- This command will display a list of games that cost between 10 and 25 --


create table sales(
id int primary key auto_increment,
Client_Name varchar(100) NOT NULL,
physical_copy_order varchar(10) NOT NULL,
id_store int,
id_game int,
constraint foreign key (id_store) references stores(Store_ID),
constraint foreign key (id_game) references games(id)
);

-- We are adding in the sales table some important collumns that are relevant for sales data and were forgoten --
alter table sales add adress varchar(300);
alter table sales add country varchar(50);
alter table sales add email varchar(255);

-- We are removing the extra collumn that was added --
alter table sales add physical varchar(10);
alter table sales drop column physical;

select * from sales;


-- We start adding sales data --

insert into sales (Client_Name, physical_copy_order, id_store, id_game, adress, country, email) values 
("Andrei Calinescu", "Yes", 2, 9, "Strada Dorobantilor", "Romania", "andre@email.ro"),
("Yamato", "Yes", 5, 29, "Tamagawa", "Japan", "yamato@emai.com"),
("Hansel", "No", 4, 20, "Ainz", "Germany", "hansel@email.de"),
("Goebal", "No", 4, 19, "Zwei", "Germany", "Goebal@email.de");

alter table sales add order_date date; -- adding a date column and it's values for each order --
update sales set order_date = '2024-04-20' where id = 1;
update sales set order_date = '2024-04-20' where id = 2;
update sales set order_date = '2024-04-25' where id = 3;
update sales set order_date = '2024-05-14' where id = 4;
update sales set order_date = '2024-05-25' where id = 5;
update sales set order_date = '2024-05-26' where id = 6;

insert into sales (Client_Name, physical_copy_order, id_store, id_game, adress, country, email, order_date) values
("Alfred Wonderkid", "no", 1, 3, "Creswell", "England", "alfred@email.com", "2024-08-03"),
("Jaimie Spencer", "no", 1, 1, "Exeter", "England", "jaimie@email.com", "2024-08-05"),
("Antonio Morata", "yes", 5, 29, "LosSantos", "Spain", "antonio@email.com", "2024-08-10");

-- we are deleting some extra rows --
delete from sales where id = '7';
delete from sales where id = '11';
delete from sales where id = '13';

-- We group the sales by country--
select count(id), Country
from sales
group by country
order by count(id) DESC;

-- we use left join to see what customers have refund requests--
select sales.Client_Name, refund_request.requestID
from sales
left join refund_request on sales.id = refund_request.saleID
order by sales.Client_Name;


select * from sales 
where country in ('Germany'); -- We use this in order to see the total of clients from a specific country --

select * from sales 
where physical_copy_order in ('Yes'); -- We also want to see which customers ordered the physical version of their product --


-- We create a table which displays the status of the physical product shippment and also for the digital orders

create table order_status(
id_status int primary key auto_increment,
id_sale int,
id_store int,
id_game int,
status_order varchar(100) NOT NULL,
constraint foreign key (id_sale) references sales (id),
constraint foreign key (id_store) references stores (Store_ID),
constraint foreign key (id_game) references games (id)
);

select * from order_status;

insert into order_status (id_sale, id_store, id_game, status_order) values
(1, 4, 4, "Shiped"),
(2, 1, 1, "Completed"),
(3, 2, 9, "Shiped"),
(4, 5, 29, "In Transition"),
(5, 4, 20, "Completed"),
(6, 4, 19, "Awaiting Payment");

alter table order_status rename column id_status to statusID;

-- The following SQL statement selects all orders with customer information --

select order_status.statusID, sales.Client_Name
from order_status
inner join sales on order_status.id_sale = sales.id;

create table refund_request(
requestID int primary key auto_increment,
saleID int,
previousorderID int,
refund_result varchar(50)
);

select * from refund_request;

insert into refund_request (saleID, previousorderID, refund_result) values
(4, 4, "Declined");




