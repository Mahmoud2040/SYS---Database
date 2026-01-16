-- Video URL : https://youtu.be/f52IRj9a_EQ


CREATE DATABASE simple_restaurant;
use simple_restaurant;
-- =========================
-- USERS
-- =========================
CREATE TABLE users (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       full_name VARCHAR(100),
                       phone VARCHAR(20),
                       email VARCHAR(100),
                       registered_at DATETIME,
                       loyalty_points INT DEFAULT 0,
                       created_at DATETIME,
                       updated_at DATETIME,
                       deleted_at DATETIME
);

-- lp >500  Regular
-- lP > 5000 VIP
-- lp > 10000 VIP_PLUS
-- else NEW_USER

SELECT full_name , loyalty_points , (
    case
        when loyalty_points >2500 then 'VIP_PLUS'
    when loyalty_points >= 1500 then 'VIP'
    when loyalty_points >500 then 'Regular'
    else 'new'
    end
    ) as Customer_level
from users;

INSERT INTO users VALUES
                      (1,'Ahmed Hassan','01011111111','ahmed@gmail.com','2023-01-10',500,NOW(),NOW(),NULL),
                      (2,'Mohamed Ali','01022222222','mohamed@gmail.com','2023-02-15',1200,NOW(),NOW(),NULL),
                      (3,'Sara Mahmoud','01033333333','sara@gmail.com','2023-03-20',200,NOW(),NOW(),NULL),
                      (4,'Mona Adel','01044444444','mona@gmail.com','2023-04-25',3000,NOW(),NOW(),NULL),
                      (5,'Youssef Samir','01055555555','youssef@gmail.com','2023-05-01',50,NOW(),NOW(),NULL),
                      (6,'Omar Khaled','01066666666','omar@gmail.com','2023-06-10',700,NOW(),NOW(),NULL),
                      (7,'Nour Ibrahim','01077777777','nour@gmail.com','2023-07-15',0,NOW(),NOW(),NULL),
                      (8,'Hany Mostafa','01088888888','hany@gmail.com','2023-08-01',900,NOW(),NOW(),NULL),
                      (9,'Salma Fathy','01099999999','salma@gmail.com','2023-09-12',1500,NOW(),NOW(),NULL),
                      (10,'Karim Saeed','01100000000','karim@gmail.com','2023-10-05',400,NOW(),NOW(),NULL);

-- =========================
-- WALKIN CUSTOMER
-- =========================
CREATE TABLE walkin_customer (
                                 id INT PRIMARY KEY AUTO_INCREMENT,
                                 name VARCHAR(100),
                                 created_at DATETIME,
                                 updated_at DATETIME,
                                 deleted_at DATETIME
);

INSERT INTO walkin_customer VALUES
                                (1,'Walkin-1',NOW(),NOW(),NULL),
                                (2,'Walkin-2',NOW(),NOW(),NULL),
                                (3,'Walkin-3',NOW(),NOW(),NULL),
                                (4,'Walkin-4',NOW(),NOW(),NULL),
                                (5,'Walkin-5',NOW(),NOW(),NULL),
                                (6,'Walkin-6',NOW(),NOW(),NULL),
                                (7,'Walkin-7',NOW(),NOW(),NULL),
                                (8,'Walkin-8',NOW(),NOW(),NULL),
                                (9,'Walkin-9',NOW(),NOW(),NULL),
                                (10,'Walkin-10',NOW(),NOW(),NULL);

-- =========================
-- ONLINE CUSTOMER
-- =========================
CREATE TABLE online_customer (
                                 id INT PRIMARY KEY AUTO_INCREMENT,
                                 user_id INT,
                                 address VARCHAR(255),
                                 customer_level VARCHAR(20),
                                 created_at DATETIME,
                                 updated_at DATETIME,
                                 deleted_at DATETIME
);



INSERT INTO online_customer VALUES
                                (1,1,'Nasr City','SILVER',NOW(),NOW(),NULL),
                                (2,2,'Maadi','GOLD',NOW(),NOW(),NULL),
                                (3,3,'Heliopolis','BRONZE',NOW(),NOW(),NULL),
                                (4,4,'Dokki','GOLD',NOW(),NOW(),NULL),
                                (5,5,'Mohandseen','BRONZE',NOW(),NOW(),NULL),
                                (6,6,'Shubra','SILVER',NOW(),NOW(),NULL),
                                (7,7,'New Cairo','BRONZE',NOW(),NOW(),NULL),
                                (8,8,'October','SILVER',NOW(),NOW(),NULL),
                                (9,9,'Zamalek','GOLD',NOW(),NOW(),NULL),
                                (10,10,'Giza','SILVER',NOW(),NOW(),NULL);

-- =========================
-- DELIVERY AGENT
-- =========================
CREATE TABLE delivery_agent (
                                id INT PRIMARY KEY AUTO_INCREMENT,
                                name VARCHAR(100),
                                phone VARCHAR(20),
                                created_at DATETIME,
                                updated_at DATETIME,
                                deleted_at DATETIME
);

INSERT INTO delivery_agent VALUES
                               (1,'Agent Ali','01211111111',NOW(),NOW(),NULL),
                               (2,'Agent Hassan','01222222222',NOW(),NOW(),NULL),
                               (3,'Agent Omar','01233333333',NOW(),NOW(),NULL),
                               (4,'Agent Karim','01244444444',NOW(),NOW(),NULL),
                               (5,'Agent Tamer','01255555555',NOW(),NOW(),NULL),
                               (6,'Agent Islam','01266666666',NOW(),NOW(),NULL),
                               (7,'Agent Yasser','01277777777',NOW(),NOW(),NULL),
                               (8,'Agent Fady','01288888888',NOW(),NOW(),NULL),
                               (9,'Agent Amr','01299999999',NOW(),NOW(),NULL),
                               (10,'Agent Mostafa','01300000000',NOW(),NOW(),NULL);

-- =========================
-- MENU
-- =========================
CREATE TABLE menu (
                      id INT PRIMARY KEY AUTO_INCREMENT,
                      name VARCHAR(100),
                      valid_from DATE,
                      valid_to DATE,
                      created_at DATETIME,
                      updated_at DATETIME,
                      deleted_at DATETIME
);

INSERT INTO menu VALUES
                     (1,'Breakfast Menu','2024-01-01','2024-12-31',NOW(),NOW(),NULL),
                     (2,'Lunch Menu','2024-01-01','2024-12-31',NOW(),NOW(),NULL),
                     (3,'Dinner Menu','2024-01-01','2024-12-31',NOW(),NOW(),NULL),
                     (4,'Ramadan Menu','2024-03-01','2024-04-30',NOW(),NOW(),NULL),
                     (5,'Kids Menu','2024-01-01','2025-12-31',NOW(),NOW(),NULL),
                     (6,'Dessert Menu','2024-01-01','2025-12-31',NOW(),NOW(),NULL),
                     (7,'Drinks Menu','2024-01-01','2025-12-31',NOW(),NOW(),NULL),
                     (8,'Seafood Menu','2024-01-01','2024-12-31',NOW(),NOW(),NULL),
                     (9,'Grill Menu','2024-01-01','2024-12-31',NOW(),NOW(),NULL),
                     (10,'Offers Menu','2024-06-01','2024-08-31',NOW(),NOW(),NULL);

-- =========================
-- MENU ITEM
-- =========================
CREATE TABLE menu_item (
                           id INT PRIMARY KEY AUTO_INCREMENT,
                           menu_id INT,
                           name VARCHAR(100),
                           category VARCHAR(50),
                           price DECIMAL(10,2),
                           cost DECIMAL(10,2),
                           created_at DATETIME,
                           updated_at DATETIME,
                           deleted_at DATETIME
);

INSERT INTO menu_item VALUES
                          (1,1,'Foul','MAIN',15,8,NOW(),NOW(),NULL),
                          (2,1,'Taameya','SIDE',10,5,NOW(),NOW(),NULL),
                          (3,2,'Koshary','MAIN',30,18,NOW(),NOW(),NULL),
                          (4,2,'Molokhia','MAIN',45,25,NOW(),NOW(),NULL),
                          (5,3,'Grilled Chicken','MAIN',90,55,NOW(),NOW(),NULL),
                          (6,3,'Beef Steak','MAIN',150,95,NOW(),NOW(),NULL),
                          (7,4,'Ramadan Meal','MAIN',120,70,NOW(),NOW(),NULL),
                          (8,5,'Kids Burger','MAIN',40,22,NOW(),NOW(),NULL),
                          (9,6,'Basbousa','DESSERT',25,12,NOW(),NOW(),NULL),
                          (10,7,'Fresh Juice','DRINK',20,7,NOW(),NOW(),NULL);

-- =========================
-- ORDERS
-- =========================

-- get all online customers with more than 1 orders
select online_customer_id from orders
where  order_type = 'ONLINE'
group by online_customer_id
having count(*)>1;
;


-- get rest data from online customer table
select * , u.full_name  from online_customer oc
         inner join users u on oc.user_id = u.id
         where oc.id in (select online_customer_id from orders
                      where  order_type = 'ONLINE'
                      group by online_customer_id
                      having count(*)>1);

CREATE TABLE orders (
                        id INT PRIMARY KEY AUTO_INCREMENT,
                        order_type ENUM('WALKIN','ONLINE'),
                        walkin_customer_id INT,
                        online_customer_id INT,
                        delivery_agent_id INT,
                        payment_method VARCHAR(20),
                        total_amount DECIMAL(10,2),
                        discount DECIMAL(10,2),
                        order_date DATETIME,
                        created_at DATETIME,
                        updated_at DATETIME,
                        deleted_at DATETIME
);
-- get avg
   select avg(orders.total_amount) from orders  ;

-- get orders that has total_amount > avg
    select * from orders where total_amount > (select avg(total_amount) from orders );

INSERT INTO orders VALUES
                       (1,'WALKIN',1,NULL,NULL,'CASH',80,0,NOW(),NOW(),NOW(),NULL),
                       (2,'ONLINE',NULL,1,1,'CARD',120,10,NOW(),NOW(),NOW(),NULL),
                       (3,'ONLINE',NULL,2,2,'WALLET',150,15,NOW(),NOW(),NOW(),NULL),
                       (4,'WALKIN',2,NULL,NULL,'CASH',45,0,NOW(),NOW(),NOW(),NULL),
                       (5,'ONLINE',NULL,3,3,'CARD',90,5,NOW(),NOW(),NOW(),NULL),
                       (6,'ONLINE',NULL,4,4,'WALLET',200,20,NOW(),NOW(),NOW(),NULL),
                       (7,'WALKIN',3,NULL,NULL,'CASH',60,0,NOW(),NOW(),NOW(),NULL),
                       (8,'ONLINE',NULL,5,5,'CARD',110,10,NOW(),NOW(),NOW(),NULL),
                       (9,'ONLINE',NULL,6,6,'WALLET',95,0,NOW(),NOW(),NOW(),NULL),
                       (10,'WALKIN',4,NULL,NULL,'CASH',70,0,NOW(),NOW(),NOW(),NULL);
INSERT INTO orders VALUES
                       (11,'ONLINE',NULL,1,1,'CARD',120,10,NOW(),NOW(),NOW(),NULL),
                       (12,'ONLINE',NULL,2,2,'WALLET',150,15,NOW(),NOW(),NOW(),NULL),
                       (13,'ONLINE',NULL,3,3,'CARD',90,5,NOW(),NOW(),NOW(),NULL)
                      ;
-- =========================
-- ORDER ITEM
-- =========================
CREATE TABLE order_item (
                            id INT PRIMARY KEY AUTO_INCREMENT,
                            order_id INT,
                            menu_item_id INT,
                            quantity INT,
                            created_at DATETIME,
                            updated_at DATETIME,
                            deleted_at DATETIME
);

INSERT INTO order_item VALUES
                           (1,1,1,2,NOW(),NOW(),NULL),
                           (2,1,2,3,NOW(),NOW(),NULL),
                           (3,2,3,1,NOW(),NOW(),NULL),
                           (4,2,4,2,NOW(),NOW(),NULL),
                           (5,3,5,1,NOW(),NOW(),NULL),
                           (6,4,6,1,NOW(),NOW(),NULL),
                           (7,5,7,1,NOW(),NOW(),NULL),
                           (8,6,8,2,NOW(),NOW(),NULL),
                           (9,7,9,3,NOW(),NOW(),NULL),
                           (10,8,10,2,NOW(),NOW(),NULL);

-- =========================
-- ORDER STATUS
-- =========================
CREATE TABLE order_status (
                              id INT PRIMARY KEY AUTO_INCREMENT,
                              status_name VARCHAR(50),
                              created_at DATETIME,
                              updated_at DATETIME,
                              deleted_at DATETIME
);

INSERT INTO order_status VALUES
                             (1,'CREATED',NOW(),NOW(),NULL),
                             (2,'CONFIRMED',NOW(),NOW(),NULL),
                             (3,'PREPARING',NOW(),NOW(),NULL),
                             (4,'READY',NOW(),NOW(),NULL),
                             (5,'OUT_FOR_DELIVERY',NOW(),NOW(),NULL),
                             (6,'DELIVERED',NOW(),NOW(),NULL),
                             (7,'CANCELLED',NOW(),NOW(),NULL),
                             (8,'FAILED',NOW(),NOW(),NULL),
                             (9,'REFUNDED',NOW(),NOW(),NULL),
                             (10,'ON_HOLD',NOW(),NOW(),NULL);

-- =========================
-- ORDER STATUS TRACKER
-- =========================


CREATE TABLE order_status_tracker (
                                      id INT PRIMARY KEY AUTO_INCREMENT,
                                      order_id INT,
                                      status_id INT,
                                      is_current BOOLEAN,
                                      status_date DATETIME,
                                      created_at DATETIME,
                                      updated_at DATETIME,
                                      deleted_at DATETIME
);

INSERT INTO order_status_tracker VALUES
                                     (1,1,1,FALSE,NOW(),NOW(),NOW(),NULL),
                                     (2,1,2,TRUE,NOW(),NOW(),NOW(),NULL),
                                     (3,2,1,FALSE,NOW(),NOW(),NOW(),NULL),
                                     (4,2,3,TRUE,NOW(),NOW(),NOW(),NULL),
                                     (5,3,1,FALSE,NOW(),NOW(),NOW(),NULL),
                                     (6,3,4,TRUE,NOW(),NOW(),NOW(),NULL),
                                     (7,4,1,TRUE,NOW(),NOW(),NOW(),NULL),
                                     (8,5,1,TRUE,NOW(),NOW(),NOW(),NULL),
                                     (9,6,1,TRUE,NOW(),NOW(),NOW(),NULL),
                                     (10,7,1,TRUE,NOW(),NOW(),NOW(),NULL);
