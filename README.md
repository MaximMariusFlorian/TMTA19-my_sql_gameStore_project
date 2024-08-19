# my_sql_gameStore_project



## Introduction

The scope of the final project for ITF Manual Testing Course is to use all gained knowledge through the course and apply them in practice, by creating a database and using multiple instructions.The database in scope was created by myself and tries to replicate multiple game stores and their sales

**Database description** : The database contains 5 tables that are connected with the following themes: stores, games, sales, order_status, refund_requests

## How to run
- Download the file
- In the SQL workbench select the File button
- Select Run SQL Script
- Select and open the downloaded file


1. ### Database schema

   The database tables are connected in the following way:
   - stores is connected with: sales, games, order_status, refund request
   - games is connected with: stores
   - sales is connected with: stores, games
   - order status is connected with: sales, stores, games
   - refund request is connected with sales


![table connection](https://github.com/user-attachments/assets/cec289f6-0c06-443d-b935-8c4e2440643f)


2. ### Database Queries

   i. DDL (Data Definition Language)
     The following instructions were writen in the scope of creating the structure of the database:
   - create database 
   - create table
  
     **The first command to run in order to obtain a database**
     
 ```
create database Game_Stores
```

**We start to populate the database with the following tables in this order**

```
create table stores(
Store_ID int primary key auto_increment,
Store_Name varchar(100) NOT NULL,
rating real);
```
```
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
```
```
create table sales(
id int primary key auto_increment,
Client_Name varchar(100) NOT NULL,
physical_copy_order varchar(10) NOT NULL,
id_store int,
id_game int,
constraint foreign key (id_store) references stores(Store_ID),
constraint foreign key (id_game) references games(id)
);
```
```
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
```

```
create table refund_request(
requestID int primary key auto_increment,
saleID int,
previousorderID int,
refund_result varchar(50)
);
```

     
  After the database and tables were created, a few alter table commands were written as:
  
     ``` 
     alter table sales add physical varchar(10); 
     ```
     ``` 
     alter table sales add order_date date;
     ```
     ``` 
     alter table sales drop column physical;
     ```
    
2. ### DML (Data Manipulation Language)
  In order to be able to use the database, i've populated it with multiple tables that had various data necessary for performing queries and manipulate data.

 #### Below you can find all the inster instructions that were created in the scope of this project
```
insert into games (store_id, Name, Genre, rating, price, physical_copy) value
```
```
'insert into sales (Client_Name, physical_copy_order, id_store, id_game, adress, country, email) values
```
```
insert into sales (Client_Name, physical_copy_order, id_store, id_game, adress, country, email, order_date) values
```
```
insert into order_status (id_sale, id_store, id_game, status_order) values
```
```
insert into refund_request (saleID, previousorderID, refund_result) values
```

###   After the insert, there were also some updates in the following way:
```
update sales set order_date = '2024-04-20' where id = 1;
```
```
 update sales set order_date = '2024-04-20' where id = 2;
```
```
update sales set order_date = '2024-04-25' where id = 3;
```
### In order to delete some extra data, the following commands were used

```
delete from sales where id = '7';
```
```
delete from sales where id = '11';
```
```
delete from sales where id = '13';
```


 3. ### DQL (Data Queri Language)
    The DQL commands that were used for this project where the following:
    
- Where

 ```
  select * from sales 
where physical_copy_order in ('Yes');
```

- IN

```
select * from sales 
where country in ('Germany');
```
  
- Between

```
SELECT * FROM games
WHERE price BETWEEN 10 AND 25
```

- Inner Join

```
select order_status.statusID, sales.Client_Name
from order_status
inner join sales on order_status.id_sale = sales.id;
```
  
- Left Join:

```
select sales.Client_Name, refund_request.requestID
from sales
left join refund_request on sales.id = refund_request.saleID
order by sales.Client_Name;
```
  
- Group By
```
select count(id), Country
from sales
group by country
order by count(id) DESC;
```

 

  
    
