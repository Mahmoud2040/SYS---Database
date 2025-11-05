# [Video part1](https://youtu.be/_hsaUxXQeUE)
# [Video part2](https://youtu.be/HgRoIDyH_2U)

#  **Session 3 – Part 2: Implementing and Managing Keys in Relationships**

[Visualization](https://blog.codinghorror.com/a-visual-explanation-of-sql-joins/)
---

##  **Objective**

In this part, we’ll learn how to:

1. Implement keys in different relationship types (1:1, 1:N, N:1, M:N)
2. Add, remove, or modify keys after table creation
3. Manage dependencies between tables (update/delete actions)
4. Compare design options and choose the optimal one for each case

---

##  **Section 1 — Key Concepts Recap**

| Term                  | Meaning                                                           |
| --------------------- | ----------------------------------------------------------------- |
| **Primary Key (PK)**  | Uniquely identifies each record in a table                        |
| **Foreign Key (FK)**  | References a primary key from another table                       |
| **Unique Constraint** | Ensures all values in a column are distinct                       |
| **Composite Key**     | A primary key made from two or more columns                       |
| **Constraint**        | A rule that enforces data integrity (PK, FK, UNIQUE, CHECK, etc.) |

---

## **Section 2 — Implementing Keys per Relationship Type**

---

###  ** One-to-One (1:1)**

Each record in **Table A** has exactly one record in **Table B**.

You can implement this in **two valid ways**:

---

#### **Option A — Shared Primary Key (Strict 1:1)**

```sql
CREATE TABLE user_profile (
    user_id INT PRIMARY KEY,
    bio TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

 **Behavior:**

* The same key (user_id) identifies both user and profile.
* You can’t create a profile without an existing user.
* Deleting a user automatically breaks or removes the profile (depending on FK rule).

 **Best used when:**

* The profile is a true *extension* of the user (e.g., user details or settings).
* You want a tightly bound relationship with identical lifecycles.

---

#### **Option B — Separate ID + UNIQUE Foreign Key (Practical 1:1)**

```sql
CREATE TABLE user_profile (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE,
    bio TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

 **Behavior:**

* Each profile has its own identity (`id`).
* `user_id` is **unique**, ensuring one profile per user.
* Relationship is still logically 1:1 but more flexible.

 **Best used when:**

* You want to reference the profile independently (e.g., logging, auditing).
* You might expand the model later (e.g., allow profiles for other entities).
* You prefer consistency with ORM frameworks that expect each table to have its own PK.

---

###  ** One-to-Many (1:N)**

Each record in **Table A** can relate to many in **Table B**.

```sql
CREATE TABLE department (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE teacher (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);
```

 **Behavior:**

* Each `department` can have multiple `teachers`.
* Each `teacher` belongs to one department.

 **Best used when:**

* The “child” table (teacher) depends on the “parent” (department).
* Classic parent-child relationships in data hierarchy.

---

### 🔹 ** Many-to-One (N:1)**

This is simply the reverse view of 1:N — the same implementation applies.
No need for separate SQL, just understand that the **foreign key** always lives in the **“many”** side.

---

### 🔹 ** Many-to-Many (M:N)**

Each record in **Table A** can relate to many in **Table B**, and vice versa.
We create a **junction (bridge) table** to connect them.

You have **two main design options**:

---

#### **Option A — Composite Primary Key (Pure Relational Design)**

```sql
CREATE TABLE student_course (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (course_id) REFERENCES course(id)
);
```

 **Behavior:**

* The pair `(student_id, course_id)` must be unique.
* No duplicate enrollment for the same student and course.
* Efficient and clean for pure SQL environments.

 **Best used when:**

* You’re designing directly in SQL (no ORM).
* You don’t need a separate ID for this table.
* You want strict data integrity through composite uniqueness.

---

#### **Option B — Auto ID + Unique Pair (ORM-Friendly Design)**

```sql
CREATE TABLE student_course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    UNIQUE (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (course_id) REFERENCES course(id)
);
```

 **Behavior:**

* Each record has a unique `id` (useful for ORM systems like Hibernate, JPA, etc.).
* `(student_id, course_id)` combination is still enforced as unique.

 **Best used when:**

* You’re working with ORMs that require a single-column PK.
* You plan to extend the relationship table (e.g., add `grade`, `enrolled_at`, etc.).

---

##  **Section 3 — Altering Keys After Table Creation**

| Action                | Command                                                                                             |
| --------------------- | --------------------------------------------------------------------------------------------------- |
| Add Primary Key       | `ALTER TABLE users ADD PRIMARY KEY (id);`                                                           |
| Drop Primary Key      | `ALTER TABLE users DROP PRIMARY KEY;`                                                               |
| Add Foreign Key       | `ALTER TABLE teacher ADD CONSTRAINT fk_dept FOREIGN KEY (department_id) REFERENCES department(id);` |
| Drop Foreign Key      | `ALTER TABLE teacher DROP FOREIGN KEY fk_dept;`                                                     |
| Add UNIQUE Constraint | `ALTER TABLE user_profile ADD UNIQUE (user_id);`                                                    |

 **Tip:**
To view all constraints on a table:

```sql
SHOW CREATE TABLE table_name;
```

---

## ️ **Section 4 — Managing Dependencies**

When creating foreign keys, you can control how related data reacts to updates or deletions:

| Option                             | Description                              |
| ---------------------------------- | ---------------------------------------- |
| **ON DELETE CASCADE**              | Delete child rows when parent is deleted |
| **ON UPDATE CASCADE**              | Update FK values when parent PK changes  |
| **ON DELETE SET NULL**             | Set FK to NULL when parent is deleted    |
| **ON DELETE RESTRICT / NO ACTION** | Prevent deletion if child exists         |

**Example:**

```sql
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id)
        REFERENCES customers(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
```

 **Use carefully:**

* `CASCADE` is convenient but can cause large unintended deletions.
* Use `RESTRICT` or `SET NULL` when you want more control.

---



