
# (video )[https://youtu.be/QsTm-UOKuhE]
---

| Command                       | Purpose                |
|-------------------------------|------------------------|
| SHOW DATABASES                | List all databases     |
| CREATE DATABASE               | Create a new database  |
| USE                           | Select active database |
| SELECT DATABASE()             | Show current database  |
| DROP DATABASE                 | Delete database        |
| CREATE DATABASE IF NOT EXISTS | Safe create if missing |
| SHOW WARNINGS                 | to check any warning   |


| Command                    | Purpose                   |
| -------------------------- | ------------------------- |
| SHOW TABLES                | List all tables           |
| CREATE TABLE               | Create a table            |
| DESC / DESCRIBE            | View table structure      |
| SHOW CREATE TABLE          | Show table definition     |
| RENAME TABLE               | Rename a table            |
| DROP TABLE                 | Delete a table            |
| CREATE TABLE IF NOT EXISTS | Safe table creation       |
| SHOW COLUMNS               | Show detailed column info |
| CREATE TABLE ... LIKE      | Copy table structure      |


| Command               | Purpose                 |
| --------------------- | ----------------------- |
| ADD COLUMN            | Add new column          |
| DROP COLUMN           | Delete column           |
| RENAME COLUMN         | Rename column           |
| MODIFY                | Change data type/length |
| ADD PRIMARY KEY       | Create primary key      |
| DROP PRIMARY KEY      | Remove primary key      |
| ADD CONSTRAINT UNIQUE | Make column unique      |
| ADD FOREIGN KEY       | Link to another table   |
| RENAME TO             | Rename table            |



| Term                      | Meaning                                                                                               |
| ------------------------- | ----------------------------------------------------------------------------------------------------- |
| **Constraint**            | A rule about what data is allowed (e.g., `NOT NULL`, `PRIMARY KEY`, `UNIQUE`, `CHECK`, `FOREIGN KEY`) |
| **Attribute (or option)** | A column property that changes behavior (e.g., `AUTO_INCREMENT`, `DEFAULT`)                           |





##  **Set 1: Store Management System**

###  Requirements

1. Create a new database called `storex_db`.
2. Use the database.
3. Create a table `products` with columns:

    * `id` INT AUTO_INCREMENT PRIMARY KEY
    * `name` VARCHAR(100)
    * `price` DECIMAL(10,2)
    * `category` VARCHAR(50)
4. Create another table `suppliers` with:

    * `id` INT AUTO_INCREMENT PRIMARY KEY
    * `name` VARCHAR(100)
    * `city` VARCHAR(50)
    * `contact_number` VARCHAR(20)
5. Show all tables to confirm creation.
6. Describe both tables.
7. Add a column `stock INT` to `products`.
8. Add a column `supplier_id INT` **after** `price`.
9. Rename column `name` in `products` → `product_name`.
10. Modify column `category` to be `VARCHAR(100)` instead of 50.
11. Add a new column `added_date DATE` at the end.
12. Rename table `products` → `store_products`.
13. Add a **foreign key** in `store_products` referencing `supplier_id` → `suppliers.id`.
14. Drop the column `added_date`.
15. Show table structure again to verify the changes.
16. Create another table `categories` with columns:

    * `id` INT PRIMARY KEY AUTO_INCREMENT
    * `category_name` VARCHAR(100)
17. Add a foreign key from `store_products(category)` → `categories(category_name)`. *(for learning purpose)*
18. Create a new table `store_products_backup` **using the same structure** as `store_products`.
19. Drop the table `suppliers`.
20. Drop the database `storex_db`.

---

###  Challenge Questions

* How can you safely create `storex_db` only if it doesn’t exist?
* What’s the difference between `DROP TABLE` and `DELETE FROM`?
* How can you copy a table’s **structure only**, not its data?
* How can you rename multiple tables at once?

---

##  **Set 2: School Management System**

###  Requirements

1. Create a new database `school_db`.
2. Use it.
3. Create a table `students` with:

    * `id` INT PRIMARY KEY AUTO_INCREMENT
    * `name` VARCHAR(100)
    * `age` INT
    * `grade` VARCHAR(10)
4. Create a table `teachers` with:

    * `id` INT PRIMARY KEY AUTO_INCREMENT
    * `name` VARCHAR(100)
    * `subject` VARCHAR(50)
    * `salary` DECIMAL(10,2)
5. Add a column `email VARCHAR(100)` to `students`.
6. Add a column `phone_number VARCHAR(15)` to `teachers` **after** `name`.
7. Rename column `subject` → `subject_name`.
8. Modify `salary` column to `DECIMAL(12,2)`.
9. Add a new table `classes` with:

    * `id` INT AUTO_INCREMENT PRIMARY KEY
    * `class_name` VARCHAR(50)
    * `teacher_id` INT
10. Add a foreign key `teacher_id` → `teachers.id`.
11. Add a new column `class_id` in `students` after `grade`.
12. Add a foreign key from `students.class_id` → `classes.id`.
13. Rename table `students` → `pupils`.
14. Add a unique constraint to `pupils.email`.
15. Drop the column `age`.
16. Show structure of `pupils`.
17. Drop the table `classes`.
18. Drop the database `school_db`.

---

###  Challenge Questions

* How can you rename both `teachers` and `pupils` tables in one query?
* How would you remove all constraints from a table?
* How can you ensure you don’t lose data before dropping a table?

---

##  **Set 3: Library Management System**

###  Requirements

1. Create a new database `library_system`.
2. Use it.
3. Create a table `books` with:

    * `id` INT PRIMARY KEY AUTO_INCREMENT
    * `title` VARCHAR(150)
    * `author` VARCHAR(100)
    * `published_year` YEAR
    * `category` VARCHAR(50)
4. Create a table `members` with:

    * `id` INT AUTO_INCREMENT PRIMARY KEY
    * `full_name` VARCHAR(100)
    * `city` VARCHAR(50)
    * `age` INT
    * `email` VARCHAR(100)
5. Add a new table `borrow_records` with:

    * `id` INT AUTO_INCREMENT PRIMARY KEY
    * `book_id` INT
    * `member_id` INT
    * `borrow_date` DATE
    * `return_date` DATE
6. Add a foreign key `book_id` → `books.id`.
7. Add a foreign key `member_id` → `members.id`.
8. Add a column `phone_number VARCHAR(15)` to `members` after `email`.
9. Modify `email` to be `VARCHAR(150)` and make it UNIQUE.
10. Rename column `full_name` → `name`.
11. Add a column `membership_date DATE` at the end.
12. Rename table `members` → `library_members`.
13. Add a column `ISBN VARCHAR(20)` **after** `title` in `books`.
14. Drop the column `category` from `books`.
15. Add a column `category_id INT` instead, and create a table `categories (id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(100))`.
16. Add a foreign key from `books.category_id` → `categories.id`.
17. Show the creation query of the `borrow_records` table.
18. Create a backup of `books` table structure named `books_backup`.
19. Drop the table `categories`.
20. Drop the entire database `library_system`.

---

###  Challenge Questions

* How can you check which database you’re currently using before dropping one?
* How can you remove a foreign key constraint safely?
* What’s the difference between `DROP DATABASE` and `DROP TABLE`?
* What’s the advantage of using `CREATE IF NOT EXISTS` and `DROP IF EXISTS`?

---

