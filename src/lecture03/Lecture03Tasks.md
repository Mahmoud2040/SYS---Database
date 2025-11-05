

## **Set 1 — Basic Primary & Foreign Keys (1:N Introduction)**

1. Create database `company_db` and use it.
2. Create table `departments` with:

   * `id INT AUTO_INCREMENT PRIMARY KEY`
   * `name VARCHAR(100)`
3. Create table `employees` with:

   * `id INT AUTO_INCREMENT PRIMARY KEY`
   * `full_name VARCHAR(100)`
   * `department_id INT`
   * Add a **foreign key** linking `department_id` → `departments(id)`
4. Insert at least **3 departments** and **6 employees**, assigning each employee to a department.
5. Select all employees along with their department names using `JOIN`.
6. Insert an employee with a `department_id` that doesn’t exist — what happens?
7. Delete a department that still has employees — what error do you get?
8. Modify the `employees` table to allow cascading deletes:

   ```sql
   ALTER TABLE employees
   ADD CONSTRAINT fk_emp_dept
   FOREIGN KEY (department_id) REFERENCES departments(id)
   ON DELETE CASCADE;
   ```
9. Delete a department and check that its employees were deleted automatically.
10. Show all departments that still exist after the deletion.

---

## **Set 2 — One-to-One Relationship (Two Design Options)**

1. Create database `users_db` and use it.
2. Create table `users` with:

   * `id INT AUTO_INCREMENT PRIMARY KEY`
   * `username VARCHAR(50)`
3. **Option A — Shared Primary Key design:**
   Create table `user_profile` with:

   * `user_id INT PRIMARY KEY`
   * `bio TEXT`
   * Foreign key referencing `users(id)`
4. Insert 3 users and create matching profiles for each one.
5. Try to insert a profile for a non-existing user — what happens?
6. Drop `user_profile` and recreate it using **Option B — Separate ID + UNIQUE FK:**

   ```sql
   CREATE TABLE user_profile (
       id INT AUTO_INCREMENT PRIMARY KEY,
       user_id INT UNIQUE,
       bio TEXT,
       FOREIGN KEY (user_id) REFERENCES users(id)
   );
   ```
7. Insert new profiles again and confirm that only one profile per user is allowed.
8. Attempt to insert two profiles for the same user — what error do you get?
9. Add column `avatar_url VARCHAR(255)` to `user_profile`.
10. Delete a user — check if the foreign key prevents deletion or sets NULL (depending on your design).

---

## **Set 3 — One-to-Many and Many-to-One Combined**

1. Create database `school_relations_db` and use it.
2. Create table `departments` with:

   * `id INT AUTO_INCREMENT PRIMARY KEY`
   * `name VARCHAR(100)`
3. Create table `teachers` with:

   * `id INT AUTO_INCREMENT PRIMARY KEY`
   * `full_name VARCHAR(100)`
   * `department_id INT`
   * FK referencing `departments(id)`
4. Create table `students` with:

   * `id INT AUTO_INCREMENT PRIMARY KEY`
   * `name VARCHAR(100)`
   * `advisor_id INT`
   * FK referencing `teachers(id)`
5. Insert 3 departments, 4 teachers, and 8 students (each student has one advisor).
6. Show each student with their advisor name (JOIN).
7. Show each teacher with their department (JOIN).
8. Try deleting a teacher who has students — what happens?
9. Alter the `students` table to use `ON DELETE SET NULL` for `advisor_id`.
10. Delete a teacher again — verify that students’ `advisor_id` becomes NULL.

---

## **Set 4 — Many-to-Many Relationship (Composite Primary Key)**

1. Create database `courses_db` and use it.
2. Create tables:

   * `students (id, name)`
   * `courses (id, title)`
3. Create a linking table `student_course` with:

   * `student_id INT`
   * `course_id INT`
   * Composite PK `(student_id, course_id)`
   * FKs referencing both parent tables
4. Insert 4 students and 3 courses.
5. Insert enrollments (each student in 2–3 courses).
6. Try inserting the same `(student_id, course_id)` twice — what error do you get?
7. Show all courses each student is enrolled in (JOIN across 3 tables).
8. Delete a student — confirm that their course enrollments are removed (if using `ON DELETE CASCADE`).
9. Add a new column `enrolled_date DATE` to `student_course`.
10. Update one record’s enrollment date and show the changes.

---

## **Set 5 — Many-to-Many with Auto ID + Unique Pair (ORM-Friendly Design)**

1. Create database `training_db` and use it.
2. Create tables:

   * `trainees (id, full_name)`
   * `programs (id, title)`
3. Create `trainee_program` with:

   * `id INT AUTO_INCREMENT PRIMARY KEY`
   * `trainee_id INT`
   * `program_id INT`
   * `UNIQUE (trainee_id, program_id)`
   * FKs referencing `trainees(id)` and `programs(id)`
4. Insert multiple records — each trainee can join many programs.
5. Attempt to add the same trainee-program pair again — what happens?
6. Add column `progress_percentage DECIMAL(5,2)` to store trainee progress.
7. Update the progress of one trainee in one program to 85%.
8. Show all trainees with their enrolled programs and progress.
9. Delete a trainee — confirm how the foreign key affects the `trainee_program` table.
10. Modify FK rules to use `ON DELETE CASCADE` and test again.

---

## **Set 6 — Advanced Relationship Management & Dependencies**

1. Create database `sales_relations_db` and use it.
2. Create `customers` with:

   * `id INT PRIMARY KEY AUTO_INCREMENT`
   * `name VARCHAR(100)`
3. Create `orders` with:

   * `id INT PRIMARY KEY AUTO_INCREMENT`
   * `customer_id INT`
   * `order_date DATE`
   * `total DECIMAL(10,2)`
   * FK referencing `customers(id)`
4. Create `products` with:

   * `id INT PRIMARY KEY AUTO_INCREMENT`
   * `name VARCHAR(100)`
   * `price DECIMAL(8,2)`
5. Create `order_items` with:

   * `order_id INT`
   * `product_id INT`
   * `quantity INT`
   * Composite PK `(order_id, product_id)`
   * FKs referencing `orders(id)` and `products(id)`
6. Insert 3 customers, 5 products, and a few orders with items.
7. Delete one customer — verify what happens to their orders.
8. Modify FK in `orders` to `ON DELETE CASCADE`, then test again.
9. Try deleting a product that is already in an order — observe the restriction.
10. Change that FK to `ON DELETE SET NULL`, then test deleting the product again.
11. Add a new column `status ENUM('pending','shipped','delivered')` to `orders`.
12. Update one order’s status to `shipped`.
13. Join all orders with customers and order items to show full purchase details.
14. Drop one of the FKs and re-add it with a different constraint — verify the behavior.

---

