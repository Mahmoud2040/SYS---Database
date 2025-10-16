# [Video Link](https://youtu.be/ZwWOV0Z6Oxk)


### Why do we need databases ❓

In earlier examples, we used data structures like `ArrayList`, `HashSet`, or `Queue` to store data in memory.
These act like **temporary in-memory databases**  data exists only while the program is running. Once the application stops, all data is lost.

To keep data **permanently**, we need a system that can:

* Store data on disk
* Retrieve and update it efficiently
* Support multiple users safely

That’s why we use **databases**  they store and manage data securely and persistently.

Before databases, data was saved using **file systems**, which we’ll discuss next.

-------------------------------------------
### What is a file system ❓

A file system stores data in files like text or CSV files.
Example:

users.txt

Mahmoud, Cairo, 25  
Ahmed, Alex, 29  
Saied, Aswan, 22


Each line represents one user.

But this method has many disadvantages, such as:

❌ Hard to search or update data (you must read the whole file).

❌ No data validation (someone could write “Age = hello”).

❌ No relationships between data (you can’t easily link users with their orders).

❌ Risk of data loss or corruption when multiple users edit the file.

That’s why databases are a better solution.

---

###  What is the difference between a Database and a DBMS❓

* A **Database** is the **actual data**  the organized collection of information stored on disk.
  Example: all your tables, records, and files.

* A **DBMS (Database Management System)** is the **software** that manages and controls access to that data.
  It lets users **add, update, delete, and query** data while handling things like **security, concurrency, and backups**.

Examples of DBMS: **MySQL**, **PostgreSQL**, **Oracle**, **SQL Server**.
So it’s **incorrect** to say “MySQL is a database”  it’s a **DBMS**.

Most DBMSs use a language called **SQL (Structured Query Language)** to interact with databases.


---

### When I download MySQL, what am I actually downloading❓

When you download **MySQL**, you’re getting several components that work together:

1.  **MySQL Server**
    The core service (the actual **DBMS**) that stores and manages your databases.
    It runs in the background and listens for connections on port **3306**.

2.  **Client Tools**
    Programs that let you talk to the server, like:

    * `mysql` command-line tool
    * **MySQL Workbench** (graphical interface)

3.  **Utilities & Libraries**
    Tools used by developers and applications to connect to MySQL (e.g., MySQL Connector for Java/Python).

4.  **Configuration Files**
    Control how the MySQL server runs (port number, storage paths, permissions, etc.).


When you install MySQL, you’re installing both the **database engine (server)** and the **tools** to connect to, manage, and use that engine.

---
