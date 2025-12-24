
# [Video URL](https://youtu.be/VyIsYITcfWg) 

#  **Lecture 4: Introduction to JOINs (with Execution Plan Logic)**

---

##  **1. Why We Need JOINs**

When you have related tables (like `students` and `courses`), JOINs allow you to combine them into a **single result set** based on matching keys.

But under the hood — JOINs are **not just “links”**;
the database engine must **scan, match, and filter** rows between tables, which affects performance.

That’s why understanding **JOIN types + execution plans** is critical.

---
| Join Type | Description | Result Set | Real-World Example |
| :--- | :--- | :--- | :--- |
| **INNER JOIN** | Returns only the records that have **matching values** in *both* Table A and Table B. | The **intersection** of the two tables. | Find **customers who have placed an order** (matching IDs in both `Customers` and `Orders`). |
| **LEFT JOIN** | Returns **all records** from the **left** table (Table A), and the matched records from the right table (Table B). If there is no match, the result is `NULL` from the right side. | The **entire left circle** plus the intersection. | List **all employees**, including those who **have not yet been assigned to a project** (project details will show `NULL`). |
| **RIGHT JOIN** | Returns **all records** from the **right** table (Table B), and the matched records from the left table (Table A). If there is no match, the result is `NULL` from the left side. | The **entire right circle** plus the intersection. | List **all available product colors**, even if there are **no products currently stocked in that color** (product details will show `NULL`). (Assuming `Colors` is the right table). |
| **FULL JOIN** | Returns **all records** when there is a match in *either* the left (Table A) or the right (Table B) table. Unmatched rows will have `NULL` values for the columns of the non-matching table. | The **union** of both tables (the entire area of both circles). | Combine a list of **attendees** and a list of **registered voters**, showing people who only attended, people who only voted, and people who did both. |
| **CROSS JOIN** | Returns the **Cartesian product** of the two tables, which means it combines every row from Table A with every row from Table B. **No join condition** (`ON` clause) is needed or used. | All possible combinations of rows (Total Rows = Rows in A x Rows in B). | Generating a list of **every possible combination** of three different **meal options** and four different **drink options** for a restaurant menu. |
| **SELF JOIN** | A conceptual join where a table is joined to **itself**. It is executed using any of the other join types (typically `INNER` or `LEFT`), but it requires using table aliases. | The result depends on the underlying join type and the condition used to match rows within the same table. | Finding **all employees who report to the same manager** using an `Employee` table with both an `EmployeeID` and a `ManagerID` column. |


##  **2. Basic Concept**

```sql
SELECT columns
FROM tableA
JOIN tableB
ON tableA.column = tableB.column;
```

The **optimizer** decides:

* Which table to start with (the “driving” table)
* How to find matches (via indexes, hash, nested loops, etc.)
* Whether to include unmatched rows or not

---

##  **3. JOIN Types with Execution Flow**

---

###  **INNER JOIN**

Returns only matching rows between both tables.

**Example:**

```sql
SELECT e.name, d.name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.id;
```

**Execution Plan Tree (Conceptual):**

```
→ JOIN (type: INNER)
    ├── TABLE SCAN (employees)
    └── INDEX LOOKUP (departments.id)
```

**Explanation:**

1. MySQL scans each row in `employees` (left table).
2. For each, it looks up a matching `department_id` in `departments`.
3. Only rows that match both sides are returned.

**Performance Notes:**

* Fastest when **foreign key columns are indexed**.
* Large INNER JOINs without indexes → costly nested loops.
* Filtering (`WHERE`) should happen **before** the JOIN if possible.

 **Optimal When:**
You only need matched data (most typical scenario).

---

### 🔸 **LEFT JOIN**

Returns all rows from left table even if no match in right.

**Example:**

```sql
SELECT u.name, p.bio
FROM users u
LEFT JOIN profiles p
ON u.id = p.user_id;
```

**Execution Plan Tree:**

```
→ JOIN (type: LEFT OUTER)
    ├── TABLE SCAN (users)
    └── INDEX LOOKUP (profiles.user_id)
        └── if no match → NULL placeholder row
```

**Explanation:**

1. Engine reads all users first (driving table).
2. For each user, it tries to find a matching profile.
3. If no profile exists, it still keeps the user row with NULLs.

**Performance Notes:**

* Needs index on `profiles.user_id`.
* If the right table is huge and poorly indexed, performance drops.
* Filtering in `WHERE` after LEFT JOIN can accidentally turn it into INNER JOIN (common mistake).

 **Optimal When:**
You must keep all left-side rows (e.g., “show all users even if no profile”).

---

###  **RIGHT JOIN**

Returns all rows from right table, matched or not.

**Example:**

```sql
SELECT d.name, e.full_name
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.id;
```

**Execution Plan Tree:**

```
→ JOIN (type: RIGHT OUTER)
    ├── INDEX LOOKUP (employees.department_id)
    └── TABLE SCAN (departments)
        └── if no match → NULL placeholders for employee
```

**Explanation:**

1. Database scans the **right** table (departments).
2. For each department, it tries to find matching employees.
3. Departments without employees still appear.

**Performance Notes:**

* Same cost logic as LEFT JOIN; just reversed order.
* Often replaced by LEFT JOIN with swapped table order (more readable).

 **Optimal When:**
You primarily care about the right table (departments in this case).

---

###  **FULL OUTER JOIN**

Combines LEFT + RIGHT results (all rows from both tables).

**MySQL simulation:**

```sql
SELECT * FROM A
LEFT JOIN B ON A.id = B.a_id
UNION
SELECT * FROM A
RIGHT JOIN B ON A.id = B.a_id;
```

**Execution Flow:**

```
→ UNION (DISTINCT)
    ├── LEFT JOIN Plan (A → B)
    └── RIGHT JOIN Plan (A → B)
```

**Performance Notes:**

* MySQL runs both JOINs separately and merges results.
* Slower for large datasets, avoid unless logically necessary.

 **Optimal When:**
You must see *all* data from both sides (rarely needed in well-structured apps).

---

###  **CROSS JOIN**

Cartesian product — every row from table A combines with every row from table B.

**Example:**

```sql
SELECT a.name, b.title
FROM authors a
CROSS JOIN books b;
```

**Execution Plan:**

```
→ NESTED LOOP (type: CROSS)
    ├── TABLE SCAN (authors)
    └── TABLE SCAN (books)
```

**Explanation:**
If `authors` has 10 rows and `books` has 5, result = 10×5 = 50 rows.

**Performance Notes:**

* Extremely expensive on large tables.
* Only use intentionally (e.g., generating combinations).

 **Optimal When:**
You *want* all possible combinations (e.g., pairing every product with every region).

---

###  **SELF JOIN**

Joining a table to itself.

**Example:**

```sql
SELECT e1.name AS employee, e2.name AS manager
FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.id;
```

**Execution Plan:**

```
→ JOIN (type: INNER)
    ├── TABLE SCAN (employees AS e1)
    └── INDEX LOOKUP (employees AS e2.id)
```

**Performance Notes:**

* Both “copies” of the table are treated separately internally.
* Indexes are vital, especially on the referenced column (`manager_id`).
* Watch out for recursion or circular references.

 **Optimal When:**
You need hierarchical or comparative data from the same table.

---

## ⚡ **4. JOIN Performance Tips**

| Tip                                             | Why it matters                     |
| ----------------------------------------------- | ---------------------------------- |
| Always index foreign key columns                | Avoids full-table scans            |
| Use `EXPLAIN` before running complex joins      | Shows actual join strategy         |
| Apply filters early (`WHERE`, `ON`)             | Reduces rows to process            |
| Avoid joining large unfiltered tables           | Leads to exponential row expansion |
| Be cautious with `CROSS JOIN` or UNION of JOINs | Can blow up result size            |
| Limit columns in SELECT                         | Saves memory & bandwidth           |

---

##  **5. Summary Table**

| JOIN Type | Keeps Unmatched Rows | Engine Behavior          | Common Use           |
| --------- | -------------------- | ------------------------ | -------------------- |
| INNER     | ❌ None               | Scans & matches both     | Normal matched data  |
| LEFT      | ✅ Left only          | Includes NULLs for right | Keep all left rows   |
| RIGHT     | ✅ Right only         | Includes NULLs for left  | Keep all right rows  |
| FULL      | ✅ Both               | Runs both joins          | Combined datasets    |
| CROSS     | ❌ None               | Combines all pairs       | Combinations/tests   |
| SELF      | Depends              | Dual scan of same table  | Hierarchy or mapping |

---




##  **Set 1: Library Loan Management**

### **Goal:** Practice INNER, LEFT, and RIGHT JOIN between multiple related tables.

#### **Requirements**

1. Create database `library_db` and use it.
2. Create tables:

```sql
CREATE TABLE member (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    join_date DATE
);

CREATE TABLE book (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100)
);

CREATE TABLE loan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES member(id),
    FOREIGN KEY (book_id) REFERENCES book(id)
);
```

3. Insert at least **5 members**, **5 books**, and **8 loan records**.

    * Include some members who didn’t borrow anything.
    * Include some loans without a return date.

4. Queries to practice:

    1. Show all borrowed books with member names.
    2. Show all members who never borrowed any book.
    3. Show all books and the member who borrowed them (even if none — using LEFT JOIN).
    4. Show all active loans (`return_date IS NULL`).
    5. Show each member with total number of books borrowed (using `GROUP BY`).
    6. Show books borrowed more than once.
    7. Order loans by latest `loan_date`.

---

##  **Set 2: Online Course Enrollment System**

### **Goal:** Practice joining **three tables** and using conditions with joins.

#### **Requirements**

1. Create database `courses_db` and use it.
2. Create tables:

```sql
CREATE TABLE student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    major VARCHAR(100)
);

CREATE TABLE course (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    category VARCHAR(100)
);

CREATE TABLE enrollment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrolled_on DATE,
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (course_id) REFERENCES course(id)
);
```

3. Insert:

    * **5 students**
    * **5 courses**
    * **8 enrollments**

4. Practice queries:

    1. Show all students with the courses they enrolled in.
    2. Show students who are **not enrolled** in any course (LEFT JOIN + `WHERE enrollment.id IS NULL`).
    3. Show each course with how many students are enrolled.
    4. Show all “Programming” category courses and the students in them.
    5. Show students enrolled after `'2025-01-01'`.
    6. Show the total number of enrollments.
    7. Show all unique course categories.

---

##  **Set 3: Company Employee and Department**

### **Goal:** Practice **many-to-one** and **many-to-many joins** with lookup tables.

#### **Requirements**

1. Create database `company_db` and use it.
2. Create tables:

```sql
CREATE TABLE department (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE employee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);

CREATE TABLE project (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE employee_project (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    project_id INT,
    assigned_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employee(id),
    FOREIGN KEY (project_id) REFERENCES project(id)
);
```

3. Insert:

    * **3 departments**
    * **6 employees**
    * **3 projects**
    * **8 assignments** in `employee_project`

4. Practice queries:

    1. Show all employees with their department names (INNER JOIN).
    2. Show all departments and employees (including empty ones) — `LEFT JOIN`.
    3. Show each project and employees working on it (many-to-many join).
    4. Show employees assigned to more than one project.
    5. Show projects that have no assigned employees.
    6. Show total employees per department.
    7. Order all assignments by `assigned_date DESC`.
