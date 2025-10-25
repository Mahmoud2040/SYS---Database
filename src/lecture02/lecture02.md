
# [video](https://youtu.be/NElso-FoALM)

##  Working with Data (DML Commands)**

| Command            | Purpose                                          | Example                                                           |
| ------------------ | ------------------------------------------------ | ----------------------------------------------------------------- |
| **INSERT INTO**    | Add new records (rows) into a table.             | `INSERT INTO users (name, email) VALUES ('Ali', 'ali@mail.com');` |
| **SELECT**         | Retrieve data from a table.                      | `SELECT name, email FROM users;`                                  |
| **UPDATE**         | Modify existing records.                         | `UPDATE users SET status = 'inactive' WHERE id = 3;`              |
| **DELETE**         | Remove records from a table.                     | `DELETE FROM users WHERE id = 5;`                                 |
| **TRUNCATE TABLE** | Delete all rows quickly (resets AUTO_INCREMENT). | `TRUNCATE TABLE users;`                                           |

---

##  ** Add-ons (Clauses and Conditions)**

| Keyword      | Purpose                            | Example                                                    |
| ------------ | ---------------------------------- | ---------------------------------------------------------- |
| **WHERE**    | Filter rows based on a condition.  | `SELECT * FROM users WHERE age > 25;`                      |
| **ORDER BY** | Sort the results.                  | `SELECT * FROM users ORDER BY created_at DESC;`            |
| **LIMIT**    | Limit the number of returned rows. | `SELECT * FROM users LIMIT 10;`                            |
| **LIKE**     | Search patterns in text.           | `SELECT * FROM users WHERE name LIKE '%ah%';`              |
| **IN**       | Match multiple possible values.    | `SELECT * FROM users WHERE country IN ('US', 'UK', 'CA');` |
| **BETWEEN**  | Range filtering.                   | `SELECT * FROM sales WHERE amount BETWEEN 100 AND 500;`    |



##  **Set 1: Employee Management System**

#### **Requirements**

1. Create a new database `company_db` and use it.
2. Create a table `employees` with:

    * `id INT AUTO_INCREMENT PRIMARY KEY`
    * `name VARCHAR(100)`
    * `department VARCHAR(50)`
    * `salary DECIMAL(10,2)`
    * `hire_date DATE`
    * `city VARCHAR(50)`
3. Insert at least **10 employees** with different departments, salaries, and cities.
4. Show all employees.
5. Select only employees who work in the **"IT"** department.
6. Show employees with a salary **greater than 5000**.
7. Show employees hired **after 2022-01-01**.
8. Display employees **from “Cairo” OR “Alexandria”**.
9. List employees ordered by **salary descending**.
10. Show only the **top 3 highest salaries**.
11. Display all unique departments.
12. Show all employees where name **starts with ‘A’**.
13. Show all employees **not in IT** department.
14. Count how many employees are in each department *(hint: use COUNT and GROUP BY later — but optional now)*.

---

##  **Set 2: Online Store Orders**

### **Goal:** Practice `UPDATE`, `DELETE`, `BETWEEN`, `IN`, and `LIKE`.

#### **Requirements**

1. Create database `onlinestore_db` and use it.
2. Create a table `orders` with:

    * `id INT AUTO_INCREMENT PRIMARY KEY`
    * `customer_name VARCHAR(100)`
    * `product VARCHAR(100)`
    * `quantity INT`
    * `price DECIMAL(10,2)`
    * `order_date DATE`
    * `status VARCHAR(20)` (default `'pending'`)
3. Insert **8–10 orders** with different customers, products, and dates.
4. Select all orders.
5. Update order status to `'shipped'` where `id = 2`.
6. Update all orders where `status = 'pending'` and `order_date` < `'2024-01-01'` → set to `'expired'`.
7. Delete all orders where `status = 'expired'`.
8. Select orders where `quantity BETWEEN 2 AND 5`.
9. Select orders where `product IN ('Laptop', 'Phone', 'Headphones')`.
10. Select all orders where customer name **contains** `'ah'` (case-insensitive).
11. Show all orders where price > 2000 **and** quantity ≥ 2.
12. Show all remaining orders sorted by `order_date DESC`.

---

##  **Set 3: Restaurant Feedback System**

### **Goal:** Combine all DML and SELECT clauses into more complex queries.

#### **Requirements**

1. Create database `restaurant_db` and use it.
2. Create table `feedback` with:

    * `id INT AUTO_INCREMENT PRIMARY KEY`
    * `customer_name VARCHAR(100)`
    * `rating INT`
    * `comment TEXT`
    * `visit_date DATE`
    * `branch VARCHAR(50)`
3. Insert at least **12 records** with different ratings, branches, and dates.
4. Show all feedbacks with rating **>= 4**.
5. Select feedbacks from the **"Downtown"** branch only.
6. Show customers who visited between `'2024-06-01'` and `'2024-06-30'`.
7. Display all comments where comment text contains the word `'food'`.
8. Change all ratings below 3 to 3 (minimum acceptable rating).
9. Delete all feedbacks where `rating = 1`.
10. Show the **highest rating** and **lowest rating** using `MAX()` and `MIN()`.
11. Show feedbacks ordered by `visit_date DESC`.
12. Show distinct branch names.
13. Count how many feedbacks each branch received. *(optional if GROUP BY not covered yet)*
14. Show all records but only the first 5 results.

---