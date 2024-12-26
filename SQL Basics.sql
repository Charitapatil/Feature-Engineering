1. Create a table called employees with the following structure?
: emp_id (integer, should not be NULL and should be a primary key)Q
: emp_name (text, should not be NULL)Q
: age (integer, should have a check constraint to ensure the age is at least 18)Q
: email (text, should be unique for each employee)Q
: salary (decimal, with a default value of 30,000).

Write the SQL query to create the above table with all constraints.
CREATE TABLE employees (
    emp_id INTEGER NOT NULL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    age INTEGER CHECK (age >= 18),
    email TEXT UNIQUE,
    salary DECIMAL DEFAULT 30000
);

2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
examples of common types of constraints.
Constraints in a database are rules that enforce the validity, accuracy, and consistency of data stored in the tables. Their primary purpose is to maintain data integrity and prevent invalid or erroneous data from being inserted, updated, or deleted. They ensure that the data adheres to specific requirements, making the database reliable and ensuring that it reflects real-world rules or business logic.

By using constraints, databases can enforce:

Accuracy: Ensuring that the data is correct according to predefined rules.
Consistency: Maintaining uniformity in data across tables and preventing violations of relationships between tables.
Reliability: Ensuring that the data adheres to certain conditions, reducing errors and maintaining the database's trustworthiness.
Data Security: Restricting certain types of data to be entered or updated in the wrong way.
Common Types of Constraints
Here are some common types of constraints:

NOT NULL:

Purpose: Ensures that a column does not contain NULL values. This is useful when you want to make sure that certain fields always have a value.
Example:
sql
Copy code
CREATE TABLE employees (
    emp_id INTEGER NOT NULL,
    emp_name TEXT NOT NULL
);
In this example, emp_id and emp_name cannot be NULL.
PRIMARY KEY:

Purpose: Uniquely identifies each row in a table. A primary key ensures that the column or combination of columns is unique and that no NULL values are allowed.
Example:
sql
Copy code
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY,
    emp_name TEXT
);
In this case, emp_id must be unique for each employee.
FOREIGN KEY:

Purpose: Establishes a relationship between two tables by enforcing referential integrity. It ensures that the value in one table matches a value in another table.
Example:
sql
Copy code
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    emp_id INTEGER,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
Here, emp_id in the orders table must match an existing emp_id in the employees table.
UNIQUE:

Purpose: Ensures that all values in a column are unique. Unlike the primary key, a column with a UNIQUE constraint can allow NULL values, but no two rows can have the same value in that column.
Example:
sql
Copy code
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY,
    emp_name TEXT,
    email TEXT UNIQUE
);
The email column must contain unique values, ensuring that no two employees have the same email address.
CHECK:

Purpose: Ensures that the value in a column meets a specified condition. It can be used to enforce domain integrity by limiting the range of values for a column.
Example:
sql
Copy code
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY,
    emp_name TEXT,
    age INTEGER CHECK (age >= 18)
);
The age column must have values that are greater than or equal to 18.
DEFAULT:

Purpose: Assigns a default value to a column if no value is provided during an insert operation.
Example:
sql
Copy code
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY,
    emp_name TEXT,
    salary DECIMAL DEFAULT 30000
);

3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
your answer.
The NOT NULL constraint is applied to a column when you want to ensure that every record (row) in the table has a valid, non-empty value for that column. This means that no NULL values will be allowed in the column, and every entry must contain some meaningful data.

Reasons for applying NOT NULL:
Data Integrity: Ensures that critical data is always provided. For example, you wouldn't want to store a record of an employee without a name or an order without a customer ID. The NOT NULL constraint enforces this rule.
Business Logic: Some business processes might require certain information to be present for any transaction or record. For example, an employee's age or a customer's email address might be essential for processing.
Preventing Missing Data: It helps avoid situations where incomplete or missing data might lead to errors in processing or reporting.
Better Performance: By ensuring that the column always has data, indexes and queries may perform more efficiently because NULL values are avoided, and comparisons can be faster.
Example:
sql
Copy code
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY,
    emp_name TEXT NOT NULL,  -- Name is required, cannot be NULL
    age INTEGER NOT NULL     -- Age is required, cannot be NULL
);
In this example, both emp_name and age are required for each employee record, so they cannot be NULL.

Can a Primary Key Contain NULL Values?
No, a primary key cannot contain NULL values. This is because the primary key must uniquely identify each row in a table, and NULL values do not provide a meaningful or unique identification.

Justification:
Uniqueness Requirement: The primary key is meant to uniquely identify a row. Since NULL represents the absence of a value and is considered "unknown," it cannot uniquely identify a row. Having NULL in the primary key would violate this uniqueness rule.
Non-Null: The primary key must have a value for every row to ensure there are no ambiguities in identifying records. If a primary key allowed NULL, it would mean there could be multiple rows with "unknown" primary keys, breaking the integrity of the database.
Data Integrity: Allowing NULL in a primary key would cause issues in referential integrity when other tables reference this key. Foreign keys depend on the primary key's ability to uniquely identify records, and NULL would create inconsistencies.
Example:
sql
Copy code
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY,  -- emp_id cannot be NULL
    emp_name TEXT
);

4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
example for both adding and removing a constraint.
1. Adding a Constraint
To add a constraint to an existing table, you use the ALTER TABLE command. There are different types of constraints you might want to add, such as NOT NULL, CHECK, FOREIGN KEY, UNIQUE, etc.

General Syntax:
sql
Copy code
ALTER TABLE table_name
ADD CONSTRAINT constraint_name constraint_type (column_name);
Example: Adding a CHECK Constraint
Suppose you have a table employees, and you want to add a CHECK constraint that ensures the salary column is greater than or equal to 10000.

sql
Copy code
ALTER TABLE employees
ADD CONSTRAINT salary_check CHECK (salary >= 10000);
In this case:

employees: The name of the table.
salary_check: The name of the new constraint.
CHECK (salary >= 10000): The condition applied to the salary column to ensure it's greater than or equal to 10000.
Example: Adding a FOREIGN KEY Constraint
If you want to add a foreign key constraint on the emp_id column in the orders table, referencing the emp_id in the employees table, you would use the following SQL:

sql
Copy code
ALTER TABLE orders
ADD CONSTRAINT fk_employee FOREIGN KEY (emp_id) REFERENCES employees(emp_id);
Here:

fk_employee: The name of the foreign key constraint.
FOREIGN KEY (emp_id): Specifies the column that is being constrained.
REFERENCES employees(emp_id): Specifies the referenced table (employees) and column (emp_id).
2. Removing a Constraint
To remove a constraint, you also use the ALTER TABLE command, but this time with the DROP CONSTRAINT clause. You need to specify the name of the constraint you want to remove.

General Syntax:
sql
Copy code
ALTER TABLE table_name
DROP CONSTRAINT constraint_name;
Example: Removing a CHECK Constraint
Suppose you want to remove the salary_check constraint (added earlier) from the employees table:

sql
Copy code
ALTER TABLE employees
DROP CONSTRAINT salary_check;
In this example:

employees: The name of the table.
salary_check: The name of the constraint being dropped.
Example: Removing a FOREIGN KEY Constraint
If you want to remove the foreign key constraint fk_employee from the orders table, you would use the following SQL:

sql
Copy code
ALTER TABLE orders
DROP CONSTRAINT fk_employee;
Here:

orders: The name of the table.
fk_employee: The name of the foreign key constraint to be removed.

5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint.
Constraints are crucial for maintaining the integrity and consistency of data in a relational database. Violating a constraint while inserting, updating, or deleting data can lead to several issues:

Data Integrity Issues: Violating constraints can result in inconsistent, incorrect, or incomplete data being stored in the database. This can cause errors, discrepancies, and confusion in applications relying on that data.

Transaction Rollback: When a violation occurs, the database will typically prevent the operation from completing. In many cases, the database will rollback the entire transaction, meaning no data will be inserted, updated, or deleted. This prevents the violation from affecting other parts of the system.

Error Handling: Most database management systems (DBMS) will throw an error when a constraint violation occurs. This will be returned to the application, signaling that something went wrong.

Performance Issues: In some situations, large sets of data might be rejected due to a constraint violation, especially if multiple rows are involved in the operation. This could result in performance inefficiencies or the need to correct the data manually.

Types of Violations and Their Consequences
1. Violation of NOT NULL Constraint
Cause: Trying to insert or update a NULL value into a column that has the NOT NULL constraint.
Consequence: The operation is rejected, and an error message is generated. The column must contain a non-NULL value.
Example:

sql
INSERT INTO employees (emp_id, emp_name) VALUES (1, NULL);
Error Message:

sql
ERROR: null value in column "emp_name" violates not-null constraint
2. Violation of PRIMARY KEY Constraint
Cause: Inserting a duplicate value into a column that is defined as the primary key.
Consequence: The operation is rejected, and the system ensures that no two rows have the same value for the primary key.
Example:

sql
INSERT INTO employees (emp_id, emp_name) VALUES (1, 'John Doe');
INSERT INTO employees (emp_id, emp_name) VALUES (1, 'Jane Smith');
Error Message:

vbnet
ERROR: duplicate key value violates unique constraint "employees_pkey"
DETAIL: Key (emp_id)=(1) already exists.
3. Violation of FOREIGN KEY Constraint
Cause: Trying to insert or update a value in a foreign key column that does not exist in the referenced table.
Consequence: The operation is rejected, ensuring referential integrity is maintained between tables.
Example:

sql
INSERT INTO orders (order_id, emp_id) VALUES (101, 999);
Here, emp_id = 999 does not exist in the employees table.

Error Message:

sql
ERROR: insert or update on table "orders" violates foreign key constraint "orders_emp_id_fkey"
DETAIL: Key (emp_id)=(999) is not present in table "employees".
4. Violation of CHECK Constraint
Cause: Trying to insert or update a value that does not meet the conditions specified in a CHECK constraint.
Consequence: The operation is rejected to ensure the data meets the required condition.
Example:

sql
INSERT INTO employees (emp_id, emp_name, age) VALUES (2, 'Alice', 16);
Assuming there's a CHECK constraint ensuring age >= 18, this will violate that condition.

Error Message:

sql
ERROR: check constraint "age_check" violated
DETAIL: Failing row contains (2, Alice, 16).
5. Violation of UNIQUE Constraint
Cause: Trying to insert or update a value that duplicates a value in a column with a UNIQUE constraint.
Consequence: The operation is rejected, ensuring that each value in the column is unique.
Example:

sql
INSERT INTO employees (emp_id, emp_name, email) VALUES (3, 'Bob', 'bob@example.com');
INSERT INTO employees (emp_id, emp_name, email) VALUES (4, 'Charlie', 'bob@example.com');
Here, the email bob@example.com is already used in the first insert.

Error Message:

vbnet
ERROR: duplicate key value violates unique constraint "employees_email_key"
DETAIL: Key (email)=(bob@example.com) already exists.
Example Scenario: A Full Workflow
Imagine we have a table employees with the following structure:

sql
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY,
    emp_name TEXT NOT NULL,
    age INTEGER CHECK (age >= 18),
    email TEXT UNIQUE
);
Step 1: Trying to Insert Invalid Data

sql
INSERT INTO employees (emp_id, emp_name, age, email)
VALUES (1, 'John Doe', 25, 'johndoe@example.com');  -- Valid insert
This insert would succeed because all constraints are satisfied.

Step 2: Violation of UNIQUE Constraint

sql
INSERT INTO employees (emp_id, emp_name, age, email)
VALUES (2, 'Jane Smith', 30, 'johndoe@example.com');  -- Duplicate email
The second insert will fail because johndoe@example.com is already used by John Doe.

Error Message:

vbnet
ERROR: duplicate key value violates unique constraint "employees_email_key"
DETAIL: Key (email)=(johndoe@example.com) already exists.

6. You created a products table without constraints as follows:

CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price DECIMAL(10, 2));
Now, you realise that?
: The product_id should be a primary keyQ
: The price should have a default value of 50.00
To modify the products table according to your new requirements, we need to:

Add the PRIMARY KEY constraint to the product_id column.
Set a default value of 50.00 for the price column.
Since the products table was created without any constraints, we will use the ALTER TABLE statement to add these constraints.

SQL Commands to Modify the Table
1. Add a PRIMARY KEY constraint to product_id:
sql
Copy code
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);
2. Set a default value of 50.00 for the price column:
sql
Copy code
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;
Final Steps
Primary Key: This ensures that product_id is unique for each row and cannot be NULL.
Default Value: This ensures that if no value is provided for price when inserting a new row, the default value of 50.00 will be automatically assigned to the column.
Full Example
Here is the complete set of SQL commands to make the changes:

sql
Copy code
-- Add PRIMARY KEY constraint on product_id
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

-- Set default value of 50.00 for price column
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

7. You have two tables:Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
SQL Query Using INNER JOIN
To fetch the student_name and class_name for each student, you can use the following INNER JOIN query:

sql
Copy code
SELECT students.student_name, classes.class_name
FROM students
INNER JOIN classes ON students.class_id = classes.class_id;
Explanation:
INNER JOIN: This ensures that only students who have a matching class_id in the classes table will be included in the result.
students.student_name: Fetches the student_name from the students table.
classes.class_name: Fetches the class_name from the classes table.
ON students.class_id = classes.class_id: This is the condition that matches students to their respective classes by the class_id field.
Example Output:
If the data in the tables is as follows:

students:

student_id	student_name	class_id
1	Alice	101
2	Bob	102
3	Charlie	101
classes:

class_id	class_name
101	Math
102	Science
The query would return:

student_name	class_name
Alice	Math
Bob	Science
Charlie	Math

8. Consider the following three tables:
Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
listed even if they are not associated with an order

Hint: (use INNER JOIN and LEFT JOIN).
To show all order_id, customer_name, and product_name while ensuring that all products are listed even if they are not associated with an order, we need to:

Use an INNER JOIN to link the orders and customers tables.
Use a LEFT JOIN to include all products from the products table, even those that are not linked to an order.
Assumed Table Structure:
orders table:
order_id (primary key)
customer_id (foreign key)
customers table:
customer_id (primary key)
customer_name
order_items table (associates orders with products):
order_id (foreign key)
product_id (foreign key)
products table:
product_id (primary key)
product_name
SQL Query:
sql
Copy code
SELECT orders.order_id, customers.customer_name, products.product_name
FROM products
LEFT JOIN order_items ON products.product_id = order_items.product_id
INNER JOIN orders ON order_items.order_id = orders.order_id
INNER JOIN customers ON orders.customer_id = customers.customer_id;
Explanation:
LEFT JOIN order_items: Ensures that all products are listed, even those that are not associated with any order. If a product is not in an order, the order_items will be NULL for that product.

INNER JOIN orders: Combines the order_items and orders tables based on the order_id field. This step ensures we are getting orders that exist in the orders table.

INNER JOIN customers: Combines the orders table with the customers table based on the customer_id field. This ensures the customer_name is associated with each order.

By using the LEFT JOIN on the products table, we make sure that even products without any associated orders will be included in the result.

Example Output:
If the data in the tables is as follows:

orders:

order_id	customer_id
1	101
2	102
customers:

customer_id	customer_name
101	Alice
102	Bob
order_items:

order_id	product_id
1	1001
2	1002
products:

product_id	product_name
1001	Laptop
1002	Phone
1003	Tablet
The query would return:

order_id	customer_name	product_name
1	Alice	Laptop
2	Bob	Phone
NULL	NULL	Tablet

9 Given the following tables:Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
To find the total sales amount for each product, we need to join the relevant tables and use the SUM() function to calculate the total sales for each product.

Assumed Table Structure:
orders table:

order_id (primary key)
order_date
order_items table (associates orders with products):

order_id (foreign key)
product_id (foreign key)
quantity (quantity of products in the order)
unit_price (price per unit of the product)
products table:

product_id (primary key)
product_name (name of the product)
SQL Query:
The INNER JOIN is used to join the tables, and the SUM() function will calculate the total sales for each product. We multiply the quantity and unit_price in the order_items table to get the total sales per order item, then aggregate the result using SUM().

sql
Copy code
SELECT products.product_name,
       SUM(order_items.quantity * order_items.unit_price) AS total_sales
FROM products
INNER JOIN order_items ON products.product_id = order_items.product_id
GROUP BY products.product_name;
Explanation:
INNER JOIN order_items ON products.product_id = order_items.product_id: This joins the products table with the order_items table based on the product_id. This ensures that we get data for each product in the order_items table.

SUM(order_items.quantity * order_items.unit_price): This calculates the total sales amount for each product by multiplying the quantity sold by the unit price and then summing up the result for each product.

GROUP BY products.product_name: Groups the results by the product_name to get the total sales amount for each product.

10. You are given three tables:Write a query to display the order_id, customer_name, and the quantity of products ordered by each
customer using an INNER JOIN between all three tables.
To display the order_id, customer_name, and the quantity of products ordered by each customer, we need to join the three tables: orders, order_items, and customers.

Assuming the following table structures:

orders table:

order_id (primary key)
customer_id (foreign key referencing customers table)
order_items table (associates orders with products):

order_id (foreign key referencing orders)
product_id (foreign key referencing products)
quantity (quantity of the product in the order)
customers table:

customer_id (primary key)
customer_name
SQL Query:
sql
Copy code
SELECT orders.order_id,
       customers.customer_name,
       order_items.quantity
FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id
INNER JOIN order_items ON orders.order_id = order_items.order_id;
Explanation:
INNER JOIN customers ON orders.customer_id = customers.customer_id: This joins the orders table with the customers table based on the customer_id. This gives us the customer information for each order.

INNER JOIN order_items ON orders.order_id = order_items.order_id: This joins the orders table with the order_items table based on the order_id, ensuring we get the quantity of products ordered in each order.

SELECT orders.order_id, customers.customer_name, order_items.quantity: This selects the order_id, customer_name, and quantity of products ordered by each customer.

SQL Commands
1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences.
Identifying Primary Keys and Foreign Keys in a Maven Movies Database
Let's assume we have a typical Maven Movies Database with the following tables:

movies table
actors table
directors table
movie_actors (a junction table to handle many-to-many relationships between movies and actors)
movie_directors (a junction table to handle many-to-many relationships between movies and directors)
Example Schema for the Tables
movies table:

sql
Copy code
CREATE TABLE movies (
    movie_id INT PRIMARY KEY,      -- primary key
    title VARCHAR(255),
    release_year INT
);
Primary Key: movie_id is the primary key because it uniquely identifies each movie in the movies table.
actors table:

sql
Copy code
CREATE TABLE actors (
    actor_id INT PRIMARY KEY,      -- primary key
    actor_name VARCHAR(255)
);
Primary Key: actor_id is the primary key because it uniquely identifies each actor in the actors table.
directors table:

sql
Copy code
CREATE TABLE directors (
    director_id INT PRIMARY KEY,   -- primary key
    director_name VARCHAR(255)
);
Primary Key: director_id is the primary key because it uniquely identifies each director in the directors table.
movie_actors table (Junction table for many-to-many relationship between movies and actors):

sql
Copy code
CREATE TABLE movie_actors (
    movie_id INT,                  -- foreign key
    actor_id INT,                  -- foreign key
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id)
);
Foreign Keys: movie_id (from the movies table) and actor_id (from the actors table) are foreign keys. They establish a relationship between the movie_actors table and the movies and actors tables, respectively.
Composite Primary Key: movie_id and actor_id together form a composite primary key in the movie_actors table, ensuring that each combination of movie_id and actor_id is unique.
movie_directors table (Junction table for many-to-many relationship between movies and directors):

sql
Copy code
CREATE TABLE movie_directors (
    movie_id INT,                  -- foreign key
    director_id INT,               -- foreign key
    PRIMARY KEY (movie_id, director_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (director_id) REFERENCES directors(director_id)
);
Foreign Keys: movie_id (from the movies table) and director_id (from the directors table) are foreign keys.
Composite Primary Key: movie_id and director_id together form a composite primary key in the movie_directors table.
Differences Between Primary Keys and Foreign Keys
Primary Key:

A primary key is a column (or combination of columns) in a table that uniquely identifies each row in that table.
There can be only one primary key in a table.
Primary keys cannot contain NULL values because they are used to uniquely identify records.
Example: In the movies table, movie_id is the primary key, meaning each movie must have a unique movie_id.
SQL Example:

sql
Copy code
CREATE TABLE movies (
    movie_id INT PRIMARY KEY,  -- primary key ensures uniqueness
    title VARCHAR(255),
    release_year INT
);
Foreign Key:

A foreign key is a column (or combination of columns) in a table that refers to the primary key in another table. It establishes a link between the two tables.
A foreign key allows you to enforce referential integrity between two tables. This means that the values in the foreign key column must match values in the referenced table’s primary key, or be NULL.
A foreign key can accept NULL values, unlike a primary key (which cannot).
Example: In the movie_actors table, movie_id is a foreign key that refers to the movie_id column in the movies table, and actor_id is a foreign key that refers to the actor_id column in the actors table.
SQL Example:

sql
Copy code
CREATE TABLE movie_actors (
    movie_id INT,                  -- foreign key referencing movies
    actor_id INT,                  -- foreign key referencing actors
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),  -- foreign key
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id)   -- foreign key
);

2- List all details of actors.
To list all details of actors from the actors table, you would use a simple SELECT query to retrieve all the columns for the actors. Assuming the actors table has the following structure:

Assumed Structure of the actors Table:
sql
Copy code
CREATE TABLE actors (
    actor_id INT PRIMARY KEY,      -- primary key
    actor_name VARCHAR(255),       -- name of the actor
    date_of_birth DATE,            -- date of birth
    gender VARCHAR(10)             -- gender of the actor
);
SQL Query to List All Details of Actors:
sql
Copy code
SELECT * FROM actors;
Explanation:
SELECT *: The asterisk (*) is a wildcard that selects all columns in the table.
FROM actors: This specifies the actors table from which you want to retrieve the data.
Example Output:
Assuming the actors table contains the following data:

actor_id	actor_name	date_of_birth	gender
1	Robert Downey Jr.	1965-04-04	Male
2	Scarlett Johansson	1984-11-22	Female
3	Chris Hemsworth	1983-08-11	Male
The result of the query would be:

actor_id	actor_name	date_of_birth	gender
1	Robert Downey Jr.	1965-04-04	Male
2	Scarlett Johansson	1984-11-22	Female
3	Chris Hemsworth	1983-08-11	Male
This query will display all the details (columns) for each actor in the actors table.

3 -List all customer information from DB.
Assumed Structure of the customers Table:
sql
Copy code
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,      -- primary key
    customer_name VARCHAR(255),       -- name of the customer
    email VARCHAR(255),               -- email address of the customer
    phone_number VARCHAR(20),         -- phone number of the customer
    address VARCHAR(255)              -- address of the customer
);
SQL Query to List All Customer Information:
sql
Copy code
SELECT * FROM customers;
Explanation:
SELECT *: The asterisk (*) selects all columns in the table.
FROM customers: Specifies the customers table from which to retrieve the data.
Example Output:
Assuming the customers table contains the following data:

customer_id	customer_name	email	phone_number	address
101	Alice Johnson	alice@example.com	123-456-7890	123 Elm St, NY
102	Bob Smith	bob@example.com	234-567-8901	456 Oak St, LA
103	Charlie Brown	charlie@example.com	345-678-9012	789 Pine St, SF
The result of the query would be:

customer_id	customer_name	email	phone_number	address
101	Alice Johnson	alice@example.com	123-456-7890	123 Elm St, NY
102	Bob Smith	bob@example.com	234-567-8901	456 Oak St, LA
103	Charlie Brown	charlie@example.com	345-678-9012	789 Pine St, SF

4 -List different countries.
Assumed Structure of the countries Table:
sql
Copy code
CREATE TABLE countries (
    country_id INT PRIMARY KEY,     -- primary key
    country_name VARCHAR(255),      -- name of the country
    continent VARCHAR(100)         -- continent the country belongs to
);
SQL Query to List All Countries:
sql
Copy code
SELECT country_name FROM countries;
Explanation:
SELECT country_name: This retrieves the country_name column from the countries table.
FROM countries: Specifies the countries table from which to retrieve the data.
Example Output:
Assuming the countries table contains the following data:

country_id	country_name	continent
1	United States	North America
2	Canada	North America
3	Brazil	South America
4	Australia	Oceania
5	Germany	Europe
The result of the query would be:

country_name
United States
Canada
Brazil
Australia
Germany

5 -Display all active customers.
To display all active customers from the database, we would need a way to identify whether a customer is active. Typically, this information would be stored in the customers table, often as a column indicating the customer’s status (e.g., status, is_active, or similar).

Assumed Structure of the customers Table (with an is_active column):
sql
Copy code
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,      -- primary key
    customer_name VARCHAR(255),       -- name of the customer
    email VARCHAR(255),               -- email address of the customer
    phone_number VARCHAR(20),         -- phone number of the customer
    address VARCHAR(255),             -- address of the customer
    is_active BOOLEAN                 -- column indicating if the customer is active
);
Here, the is_active column is a Boolean that indicates whether a customer is active or not. It might contain values such as TRUE (active) or FALSE (inactive).

SQL Query to Display All Active Customers:
sql
Copy code
SELECT * FROM customers
WHERE is_active = TRUE;
Explanation:
SELECT *: The asterisk (*) selects all columns in the table.
FROM customers: Specifies the customers table from which to retrieve the data.
WHERE is_active = TRUE: Filters the customers and only retrieves those who are marked as active.
Example Output:
Assuming the customers table contains the following data:

customer_id	customer_name	email	phone_number	address	is_active
101	Alice Johnson	alice@example.com	123-456-7890	123 Elm St, NY	TRUE
102	Bob Smith	bob@example.com	234-567-8901	456 Oak St, LA	FALSE
103	Charlie Brown	charlie@example.com	345-678-9012	789 Pine St, SF	TRUE
The result of the query would be:

customer_id	customer_name	email	phone_number	address	is_active
101	Alice Johnson	alice@example.com	123-456-7890	123 Elm St, NY	TRUE
103	Charlie Brown	charlie@example.com	345-678-9012	789 Pine St, SF	TRUE
This query will return all columns for customers who are marked as active (is_active = TRUE).

6 -List of all rental IDs for customer with ID 1.
To list all rental IDs for the customer with customer_id = 1, we assume that there is a rentals table that stores rental information. This table likely includes a column for the customer_id to associate rentals with specific customers.

Assumed Structure of the Tables:
rentals table:

sql
Copy code
CREATE TABLE rentals (
    rental_id INT PRIMARY KEY,       -- primary key
    customer_id INT,                 -- foreign key referencing customers
    rental_date DATE,                -- date the rental occurred
    return_date DATE                 -- date the rental was returned
);
customers table (assuming it already exists as mentioned before):

sql
Copy code
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,      -- primary key
    customer_name VARCHAR(255)        -- name of the customer
);
SQL Query to List All Rental IDs for Customer with ID = 1:
sql
Copy code
SELECT rental_id FROM rentals
WHERE customer_id = 1;
Explanation:
SELECT rental_id: This selects the rental_id column from the rentals table.
FROM rentals: Specifies the rentals table from which the data will be retrieved.
WHERE customer_id = 1: Filters the results to only show rentals associated with the customer whose customer_id is 1.
Example Output:
Assuming the rentals table contains the following data:

rental_id	customer_id	rental_date	return_date
1001	1	2024-01-10	2024-01-15
1002	1	2024-02-20	2024-02-25
1003	2	2024-03-05	2024-03-10
1004	1	2024-04-01	2024-04-05
The result of the query for customer_id = 1 would be:

rental_id
1001
1002
1004
This query will return all the rental_ids associated with the customer who has customer_id = 1.

7 - Display all the films whose rental duration is greater than 5 .
To display all the films whose rental duration is greater than 5, we would assume that there is a films table with a rental_duration column. This column stores the number of days the film can be rented.

Assumed Structure of the films Table:
sql
Copy code
CREATE TABLE films (
    film_id INT PRIMARY KEY,         -- primary key
    title VARCHAR(255),              -- title of the film
    rental_duration INT,             -- rental duration in days
    release_year INT                -- year the film was released
);
SQL Query to Display All Films with Rental Duration Greater than 5:
sql
Copy code
SELECT * FROM films
WHERE rental_duration > 5;
Explanation:
SELECT *: Selects all columns in the table.
FROM films: Specifies the films table from which to retrieve the data.
WHERE rental_duration > 5: Filters the results to show only films whose rental duration is greater than 5 days.
Example Output:
Assuming the films table contains the following data:

film_id	title	rental_duration	release_year
1	The Matrix	7	1999
2	Inception	3	2010
3	Avengers: Endgame	6	2019
4	The Dark Knight	4	2008
The result of the query would be:

film_id	title	rental_duration	release_year
1	The Matrix	7	1999
3	Avengers: Endgame	6	2019
This query will return all the films whose rental duration is greater than 5 days.

8 - List the total number of films whose replacement cost is greater than $15 and less than $20.
To list the total number of films whose replacement cost is greater than $15 and less than $20, we would assume that there is a films table with a replacement_cost column.

Assumed Structure of the films Table:
sql
Copy code
CREATE TABLE films (
    film_id INT PRIMARY KEY,         -- primary key
    title VARCHAR(255),              -- title of the film
    replacement_cost DECIMAL(10, 2), -- cost to replace the film
    release_year INT                -- year the film was released
);
SQL Query to List the Total Number of Films with Replacement Cost Greater than $15 and Less than $20:
sql
Copy code
SELECT COUNT(*) AS total_films
FROM films
WHERE replacement_cost > 15 AND replacement_cost < 20;
Explanation:
SELECT COUNT(*): The COUNT(*) function counts the total number of rows that meet the condition specified.
AS total_films: This gives a name (total_films) to the resulting count column.
FROM films: Specifies the films table from which to retrieve the data.
WHERE replacement_cost > 15 AND replacement_cost < 20: Filters the results to only include films where the replacement_cost is greater than $15 but less than $20.
Example Output:
Assuming the films table contains the following data:

film_id	title	replacement_cost	release_year
1	The Matrix	18.50	1999
2	Inception	14.00	2010
3	Avengers: Endgame	19.00	2019
4	The Dark Knight	22.00	2008
The result of the query would be:

total_films
2
This query will return the total number of films whose replacement cost is greater than $15 and less than $20. In this case, it is 2 films.

9 - Display the count of unique first names of actors.
To display the count of unique first names of actors, we would assume that there is an actors table with a column for actor_name. The query will extract the first names from the actor_name column, and then count the number of unique first names.

Assumed Structure of the actors Table:
sql
Copy code
CREATE TABLE actors (
    actor_id INT PRIMARY KEY,        -- primary key
    actor_name VARCHAR(255)          -- full name of the actor
);
SQL Query to Display the Count of Unique First Names of Actors:
sql
Copy code
SELECT COUNT(DISTINCT SUBSTRING_INDEX(actor_name, ' ', 1)) AS unique_first_names
FROM actors;
Explanation:
SUBSTRING_INDEX(actor_name, ' ', 1): This function extracts the first name from the full name in the actor_name column. It splits the actor_name at the first space (' ') and takes the part before it, assuming the name is in the format "First Last".
COUNT(DISTINCT ...): This counts the number of unique first names extracted by the SUBSTRING_INDEX function.
AS unique_first_names: This gives a name (unique_first_names) to the resulting count column.
FROM actors: Specifies the actors table from which to retrieve the data.
Example Output:
Assuming the actors table contains the following data:

actor_id	actor_name
1	Robert Downey Jr.
2	Scarlett Johansson
3	Robert Pattinson
4	Chris Hemsworth
5	Scarlett O'Hara
The result of the query would be:

unique_first_names
4
Explanation of Output:
The unique first names in this example would be: Robert, Scarlett, Chris.
Therefore, the count of unique first names would be 4, as there are four distinct first names in the table.
This query will give you the count of unique first names of actors in the actors table.

10- Display the first 10 records from the customer table .
To display the first 10 records from the customers table, you can use the LIMIT clause in SQL. This clause is used to restrict the number of rows returned by the query.

SQL Query to Display the First 10 Records from the customers Table:
sql
Copy code
SELECT * FROM customers
LIMIT 10;
Explanation:
SELECT *: Selects all columns from the customers table.
FROM customers: Specifies the customers table from which to retrieve the data.
LIMIT 10: Limits the number of records returned to 10.
Example Output:
Assuming the customers table contains the following data:

customer_id	customer_name	email	phone_number	address
1	Alice Johnson	alice@example.com	123-456-7890	123 Elm St, NY
2	Bob Smith	bob@example.com	234-567-8901	456 Oak St, LA
3	Charlie Brown	charlie@example.com	345-678-9012	789 Pine St, SF
4	David White	david@example.com	456-789-0123	101 Maple St, Chicago
5	Eva Green	eva@example.com	567-890-1234	202 Birch St, Miami
6	Fiona Blue	fiona@example.com	678-901-2345	303 Cedar St, Austin
7	George Black	george@example.com	789-012-3456	404 Pine St, Boston
8	Hannah Gold	hannah@example.com	890-123-4567	505 Oak St, Denver
9	Ian Silver	ian@example.com	901-234-5678	606 Birch St, Dallas
10	Jack Brown	jack@example.com	012-345-6789	707 Maple St, Houston
The result of the query would be:

customer_id	customer_name	email	phone_number	address
1	Alice Johnson	alice@example.com	123-456-7890	123 Elm St, NY
2	Bob Smith	bob@example.com	234-567-8901	456 Oak St, LA
3	Charlie Brown	charlie@example.com	345-678-9012	789 Pine St, SF
4	David White	david@example.com	456-789-0123	101 Maple St, Chicago
5	Eva Green	eva@example.com	567-890-1234	202 Birch St, Miami
6	Fiona Blue	fiona@example.com	678-901-2345	303 Cedar St, Austin
7	George Black	george@example.com	789-012-3456	404 Pine St, Boston
8	Hannah Gold	hannah@example.com	890-123-4567	505 Oak St, Denver
9	Ian Silver	ian@example.com	901-234-5678	606 Birch St, Dallas
10	Jack Brown	jack@example.com	012-345-6789	707 Maple St, Houston
This query will return the first 10 records from the customers table.

11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
To display the first 3 records from the customers table where the first name starts with the letter 'B', we need to filter the customer_name column for names starting with 'B'. You can use the LIKE operator with the pattern 'B%' to achieve this.

SQL Query to Display the First 3 Records with a First Name Starting with 'B':
sql
Copy code
SELECT * FROM customers
WHERE customer_name LIKE 'B%'
LIMIT 3;
Explanation:
SELECT *: Selects all columns from the customers table.
FROM customers: Specifies the customers table from which to retrieve the data.
WHERE customer_name LIKE 'B%': Filters the rows to include only those where the customer_name starts with the letter 'B'. The % symbol is a wildcard that matches any sequence of characters after 'B'.
LIMIT 3: Limits the number of rows returned to 3.
Example Output:
Assuming the customers table contains the following data:

customer_id	customer_name	email	phone_number	address
1	Alice Johnson	alice@example.com	123-456-7890	123 Elm St, NY
2	Bob Smith	bob@example.com	234-567-8901	456 Oak St, LA
3	Ben Brown	ben@example.com	345-678-9012	789 Pine St, SF
4	Bill White	bill@example.com	456-789-0123	101 Maple St, Chicago
5	Betty Green	betty@example.com	567-890-1234	202 Birch St, Miami
The result of the query would be:

customer_id	customer_name	email	phone_number	address
2	Bob Smith	bob@example.com	234-567-8901	456 Oak St, LA
3	Ben Brown	ben@example.com	345-678-9012	789 Pine St, SF
4	Bill White	bill@example.com	456-789-0123	101 Maple St, Chicago
This query will return the first 3 records where the customer_name starts with 'B'.

12 -Display the names of the first 5 movies which are rated as ‘G’.
To display the names of the first 5 movies that are rated as 'G', we assume there is a movies or films table with a column for the rating of the movie.

Assumed Structure of the films Table:
sql
Copy code
CREATE TABLE films (
    film_id INT PRIMARY KEY,         -- primary key
    title VARCHAR(255),              -- title of the movie
    rating VARCHAR(10)               -- rating of the movie (e.g., G, PG, etc.)
);
SQL Query to Display the Names of the First 5 Movies Rated 'G':
sql
Copy code
SELECT title FROM films
WHERE rating = 'G'
LIMIT 5;
Explanation:
SELECT title: Selects the title column, which contains the names of the movies.
FROM films: Specifies the films table from which to retrieve the data.
WHERE rating = 'G': Filters the rows to only include movies that are rated 'G'.
LIMIT 5: Limits the number of records returned to 5.
Example Output:
Assuming the films table contains the following data:

film_id	title	rating
1	Toy Story	G
2	Finding Nemo	G
3	The Lion King	G
4	Aladdin	G
5	Frozen	G
6	The Little Mermaid	PG
7	Moana	G
The result of the query would be:

title
Toy Story
Finding Nemo
The Lion King
Aladdin
Frozen
This query will return the first 5 movies that have a 'G' rating.

13-Find all customers whose first name starts with "a".
To find all customers whose first name starts with the letter "A", we need to filter the customer_name column for names that begin with 'A'. Assuming that the customer_name column contains full names (first name and last name), we can use the LIKE operator with the pattern 'A%' to match first names starting with "A".

SQL Query to Find All Customers Whose First Name Starts with "A":
sql
Copy code
SELECT * FROM customers
WHERE customer_name LIKE 'A%';
Explanation:
SELECT *: Selects all columns from the customers table.
FROM customers: Specifies the customers table from which to retrieve the data.
WHERE customer_name LIKE 'A%': Filters the rows to include only those where the customer_name starts with the letter 'A'. The % symbol is a wildcard that matches any sequence of characters after 'A'.
Example Output:
Assuming the customers table contains the following data:

customer_id	customer_name	email	phone_number	address
1	Alice Johnson	alice@example.com	123-456-7890	123 Elm St, NY
2	Bob Smith	bob@example.com	234-567-8901	456 Oak St, LA
3	Adam Brown	adam@example.com	345-678-9012	789 Pine St, SF
4	Andrew White	andrew@example.com	456-789-0123	101 Maple St, Chicago
5	Ben Green	ben@example.com	567-890-1234	202 Birch St, Miami
The result of the query would be:

customer_id	customer_name	email	phone_number	address
1	Alice Johnson	alice@example.com	123-456-7890	123 Elm St, NY
3	Adam Brown	adam@example.com	345-678-9012	789 Pine St, SF
4	Andrew White	andrew@example.com	456-789-0123	101 Maple St, Chicago
This query will return all customers whose first name starts with the letter 'A'.

14- Find all customers whose first name ends with "a".
To find all customers whose first name ends with the letter "a", we can use the LIKE operator with the pattern '%a'. This assumes that the customer_name column contains the full name, and we want to check for names that end with 'a'.

SQL Query to Find All Customers Whose First Name Ends with "a":
sql
SELECT * FROM customers
WHERE customer_name LIKE '%a';
Explanation:
SELECT *: Selects all columns from the customers table.
FROM customers: Specifies the customers table from which to retrieve the data.
WHERE customer_name LIKE '%a': Filters the rows to include only those where the customer_name ends with the letter 'a'. The % symbol is a wildcard that matches any sequence of characters before 'a'.
Example Output:
Assuming the customers table contains the following data:

customer_id	customer_name	email	phone_number	address
1	Alice Johnson	alice@example.com	123-456-7890	123 Elm St, NY
2	Bob Smith	bob@example.com	234-567-8901	456 Oak St, LA
3	Maria Garcia	maria@example.com	345-678-9012	789 Pine St, SF
4	Andrew White	andrew@example.com	456-789-0123	101 Maple St, Chicago
5	Ava Green	ava@example.com	567-890-1234	202 Birch St, Miami
The result of the query would be:

customer_id	customer_name	email	phone_number	address
1	Alice Johnson	alice@example.com	123-456-7890	123 Elm St, NY
3	Maria Garcia	maria@example.com	345-678-9012	789 Pine St, SF
5	Ava Green	ava@example.com	567-890-1234	202 Birch St, Miami
This query will return all customers whose first name ends with the letter 'a'.

15- Display the list of first 4 cities which start and end with ‘a’ .
To display the list of the first 4 cities that start and end with the letter 'a', we can use the LIKE operator with the pattern 'a%a'. This assumes that there is a cities table where the city_name column contains the names of cities.

SQL Query to Display the First 4 Cities That Start and End with 'a':
sql
Copy code
SELECT city_name
FROM cities
WHERE city_name LIKE 'a%a'
LIMIT 4;
Explanation:
SELECT city_name: Selects the city_name column, which contains the names of the cities.
FROM cities: Specifies the cities table from which to retrieve the data.
WHERE city_name LIKE 'a%a': Filters the rows to include only cities where the city_name starts and ends with the letter 'a'. The % symbol is a wildcard that matches any sequence of characters in between.
LIMIT 4: Limits the result to the first 4 records.
Example Output:
Assuming the cities table contains the following data:

city_id	city_name
1	Atlanta
2	Alexandria
3	Amarillo
4	Aurora
5	Austin
6	Antigua
The result of the query would be:

city_name
Atlanta
Alexandria
Amarillo
Aurora
This query will return the first 4 cities that start and end with the letter 'a'.

16- Find all customers whose first name have "NI" in any position.
To find all customers whose first name contains the substring "NI" in any position, you can use the LIKE operator with the pattern %NI%. This pattern will match any customer name where "NI" appears anywhere in the name.

SQL Query to Find All Customers Whose First Name Contains "NI":
sql
Copy code
SELECT * FROM customers
WHERE customer_name LIKE '%NI%';
Explanation:
SELECT *: Selects all columns from the customers table.
FROM customers: Specifies the customers table from which to retrieve the data.
WHERE customer_name LIKE '%NI%': Filters the rows to include only those where the customer_name contains "NI" in any position. The % symbols are wildcards that match any sequence of characters before and after "NI".
Example Output:
Assuming the customers table contains the following data:

customer_id	customer_name	email	phone_number	address
1	Alice Johnson	alice@example.com	123-456-7890	123 Elm St, NY
2	Benjamin Smith	benjamin@example.com	234-567-8901	456 Oak St, LA
3	Cindy Brown	cindy@example.com	345-678-9012	789 Pine St, SF
4	Nikolai White	nikolai@example.com	456-789-0123	101 Maple St, Chicago
5	Nina Green	nina@example.com	567-890-1234	202 Birch St, Miami
The result of the query would be:

customer_id	customer_name	email	phone_number	address
2	Benjamin Smith	benjamin@example.com	234-567-8901	456 Oak St, LA
4	Nikolai White	nikolai@example.com	456-789-0123	101 Maple St, Chicago
5	Nina Green	nina@example.com	567-890-1234	202 Birch St, Miami
This query will return all customers whose first name contains "NI" in any position within their name.

17- Find all customers whose first name have "r" in the second position .
To find all customers whose first name has "r" in the second position, we can use the LIKE operator with the pattern '_r%'. In this pattern:

The underscore (_) represents a single character in the first position.
The r is the letter in the second position.
The percentage sign (%) matches any sequence of characters after the second position.
SQL Query to Find All Customers Whose First Name Has "r" in the Second Position:
sql
Copy code
SELECT * FROM customers
WHERE customer_name LIKE '_r%';
Explanation:
SELECT *: Selects all columns from the customers table.
FROM customers: Specifies the customers table from which to retrieve the data.
WHERE customer_name LIKE '_r%': Filters the rows to include only those where the customer_name has "r" in the second position. The _ matches any single character in the first position, and the % matches any sequence of characters after the second position.
Example Output:
Assuming the customers table contains the following data:

customer_id	customer_name	email	phone_number	address
1	Alice Johnson	alice@example.com	123-456-7890	123 Elm St, NY
2	Brian Smith	brian@example.com	234-567-8901	456 Oak St, LA
3	Craig Brown	craig@example.com	345-678-9012	789 Pine St, SF
4	Eric White	eric@example.com	456-789-0123	101 Maple St, Chicago
5	Rachel Green	rachel@example.com	567-890-1234	202 Birch St, Miami
The result of the query would be:

customer_id	customer_name	email	phone_number	address
2	Brian Smith	brian@example.com	234-567-8901	456 Oak St, LA
3	Craig Brown	craig@example.com	345-678-9012	789 Pine St, SF
4	Eric White	eric@example.com	456-789-0123	101 Maple St, Chicago
This query will return all customers whose first name has the letter "r" in the second position.

18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
To find all customers whose first name starts with the letter "a" and is at least 5 characters in length, we can use the LIKE operator with the pattern 'a%' to match names starting with "a", and the LENGTH() function to check that the name is at least 5 characters long.

SQL Query to Find All Customers Whose First Name Starts with "A" and Is at Least 5 Characters Long:
sql
Copy code
SELECT * FROM customers
WHERE customer_name LIKE 'a%'
AND LENGTH(customer_name) >= 5;
Explanation:
SELECT *: Selects all columns from the customers table.
FROM customers: Specifies the customers table from which to retrieve the data.
WHERE customer_name LIKE 'a%': Filters the rows to include only those where the customer_name starts with the letter 'a'.
AND LENGTH(customer_name) >= 5: Filters further to include only those names that are at least 5 characters long.
Example Output:
Assuming the customers table contains the following data:

customer_id	customer_name	email	phone_number	address
1	Alice Johnson	alice@example.com	123-456-7890	123 Elm St, NY
2	Adam Smith	adam@example.com	234-567-8901	456 Oak St, LA
3	Anna Brown	anna@example.com	345-678-9012	789 Pine St, SF
4	Al	al@example.com	456-789-0123	101 Maple St, Chicago
5	Ava Green	ava@example.com	567-890-1234	202 Birch St, Miami
The result of the query would be:

customer_id	customer_name	email	phone_number	address
1	Alice Johnson	alice@example.com	123-456-7890	123 Elm St, NY
2	Adam Smith	adam@example.com	234-567-8901	456 Oak St, LA
3	Anna Brown	anna@example.com	345-678-9012	789 Pine St, SF
This query will return all customers whose first name starts with the letter 'A' and is at least 5 characters long.

19- Find all customers whose first name starts with "a" and ends with "o".
To find all customers whose first name starts with the letter "a" and ends with the letter "o", we can use the LIKE operator with the pattern 'a%o'. In this pattern:

The a matches the first letter of the name.
The % wildcard matches any sequence of characters in between.
The o matches the last letter of the name.
SQL Query to Find All Customers Whose First Name Starts with "A" and Ends with "O":
sql
Copy code
SELECT * FROM customers
WHERE customer_name LIKE 'a%o';
Explanation:
SELECT *: Selects all columns from the customers table.
FROM customers: Specifies the customers table from which to retrieve the data.
WHERE customer_name LIKE 'a%o': Filters the rows to include only those where the customer_name starts with the letter 'a' and ends with the letter 'o'. The % matches any sequence of characters between 'a' and 'o'.
Example Output:
Assuming the customers table contains the following data:

customer_id	customer_name	email	phone_number	address
1	Alberto	alberto@example.com	123-456-7890	123 Elm St, NY
2	Antonio	antonio@example.com	234-567-8901	456 Oak St, LA
3	Alice	alice@example.com	345-678-9012	789 Pine St, SF
4	Andrea	andrea@example.com	456-789-0123	101 Maple St, Chicago
5	Amparo	amparo@example.com	567-890-1234	202 Birch St, Miami
The result of the query would be:

customer_id	customer_name	email	phone_number	address
1	Alberto	alberto@example.com	123-456-7890	123 Elm St, NY
2	Antonio	antonio@example.com	234-567-8901	456 Oak St, LA
This query will return all customers whose first name starts with 'A' and ends with 'O'.

20 - Get the films with pg and pg-13 rating using IN operator.
To retrieve films with a "PG" or "PG-13" rating using the IN operator, you can write a query that checks the rating column against these two values.

SQL Query to Get Films with "PG" and "PG-13" Rating Using the IN Operator:
sql
Copy code
SELECT * FROM films
WHERE rating IN ('PG', 'PG-13');
Explanation:
SELECT *: Selects all columns from the films table.
FROM films: Specifies the films table from which to retrieve the data.
WHERE rating IN ('PG', 'PG-13'): Filters the rows to include only those where the rating column is either "PG" or "PG-13". The IN operator allows you to specify multiple possible values in a list, making it easier to filter for more than one condition.
Example Output:
Assuming the films table contains the following data:

film_id	title	rating
1	Toy Story	PG
2	The Dark Knight	PG-13
3	The Lion King	PG
4	The Matrix	R
5	Finding Nemo	PG
6	Spider-Man	PG-13
The result of the query would be:

film_id	title	rating
1	Toy Story	PG
2	The Dark Knight	PG-13
3	The Lion King	PG
5	Finding Nemo	PG
6	Spider-Man	PG-13
This query will return all films with the rating "PG" or "PG-13".

21 - Get the films with length between 50 to 100 using between operator.
To retrieve films with a length between 50 and 100 minutes using the BETWEEN operator, you can write a query that checks the length column for values in that range.

SQL Query to Get Films with Length Between 50 and 100 Using the BETWEEN Operator:
sql
Copy code
SELECT * FROM films
WHERE length BETWEEN 50 AND 100;
Explanation:
SELECT *: Selects all columns from the films table.
FROM films: Specifies the films table from which to retrieve the data.
WHERE length BETWEEN 50 AND 100: Filters the rows to include only those where the length of the film is between 50 and 100 minutes, inclusive. The BETWEEN operator is inclusive, meaning both 50 and 100 are included in the range.
Example Output:
Assuming the films table contains the following data:

film_id	title	length
1	Toy Story	85
2	The Dark Knight	152
3	The Lion King	88
4	The Matrix	136
5	Finding Nemo	90
6	Spider-Man	121
The result of the query would be:

film_id	title	length
1	Toy Story	85
3	The Lion King	88
5	Finding Nemo	90
This query will return all films whose length is between 50 and 100 minutes, inclusive.

22 - Get the top 50 actors using limit operator.
To retrieve the top 50 actors from a table (assuming there is an actors table), you can use the LIMIT operator. The LIMIT clause is used to specify the maximum number of rows returned by the query.

SQL Query to Get the Top 50 Actors Using the LIMIT Operator:
sql
Copy code
SELECT * FROM actors
LIMIT 50;
Explanation:
SELECT *: Selects all columns from the actors table.
FROM actors: Specifies the actors table from which to retrieve the data.
LIMIT 50: Restricts the result set to the first 50 rows from the actors table.
Example Output:
Assuming the actors table contains the following data:

actor_id	first_name	last_name
1	Brad	Pitt
2	Angelina	Jolie
3	Leonardo	DiCaprio
...	...	...
The result would show the top 50 actors based on the order of rows in the table. If no specific order is defined (i.e., no ORDER BY clause), it would simply return the first 50 rows.

If you wanted the top 50 actors sorted by their actor_id or any other criteria, you can include an ORDER BY clause:

sql
Copy code
SELECT * FROM actors
ORDER BY actor_id
LIMIT 50;
This would return the top 50 actors sorted by actor_id.

23 - Get the distinct film ids from inventory table.
To get the distinct film_id values from the inventory table, you can use the DISTINCT keyword. This will ensure that only unique film_id values are returned, removing any duplicates.

SQL Query to Get Distinct Film IDs from the Inventory Table:
sql
Copy code
SELECT DISTINCT film_id
FROM inventory;
Explanation:
SELECT DISTINCT film_id: Selects unique film_id values from the inventory table.
FROM inventory: Specifies the inventory table from which to retrieve the data.
Example Output:
Assuming the inventory table contains the following data:

inventory_id	film_id
1	101
2	102
3	101
4	103
5	104
6	102
The result of the query would be:

film_id
101
102
103
104
This query will return the distinct film_id values from the inventory table, ensuring no duplicates.

Functions
Basic Aggregate Functions:
Question 1:

Retrieve the total number of rentals made in the Sakila database.

Hint: Use the COUNT() function.
To retrieve the total number of rentals made in the Sakila database, you can use the COUNT() function on the rental table. The COUNT() function will count the total number of rows in the table, which corresponds to the total number of rentals.

SQL Query to Retrieve the Total Number of Rentals:
sql
Copy code
SELECT COUNT(*) AS total_rentals
FROM rental;
Explanation:
COUNT(*): Counts all rows in the rental table. It doesn't matter if some columns have NULL values; it will count every row.
AS total_rentals: Gives a name (total_rentals) to the result of the COUNT() function for readability.
FROM rental: Specifies the rental table from which the rentals are being counted.
Example Output:
Assuming the rental table contains the following data:

rental_id	rental_date	customer_id	inventory_id	return_date
1	2024-12-01 10:00:00	1	101	2024-12-02 10:00:00
2	2024-12-01 11:00:00	2	102	2024-12-02 11:00:00
3	2024-12-02 10:00:00	3	103	2024-12-03 10:00:00
The result of the query would be:

total_rentals
3
This query will return the total number of rentals made in the Sakila database.

Question 2:

Find the average rental duration (in days) of movies rented from the Sakila database.

Hint: Utilize the AVG() function.
To find the average rental duration (in days) of movies rented from the Sakila database, you can use the AVG() function. The rental table contains the rental_date and return_date, so you can calculate the rental duration by finding the difference between these two dates and then using AVG() to compute the average.

SQL Query to Find the Average Rental Duration (in Days):
sql
Copy code
SELECT AVG(DATEDIFF(return_date, rental_date)) AS average_rental_duration
FROM rental;
Explanation:
DATEDIFF(return_date, rental_date): This calculates the difference in days between the return_date and rental_date for each rental, giving the rental duration.
AVG(...): This function computes the average of all the rental durations calculated by DATEDIFF.
AS average_rental_duration: This gives a meaningful name to the result of the AVG() function for readability.
FROM rental: Specifies the rental table from which to retrieve the data.
Example Output:
Assuming the rental table contains the following data:

rental_id	rental_date	return_date
1	2024-12-01 10:00:00	2024-12-02 10:00:00
2	2024-12-01 11:00:00	2024-12-04 11:00:00
3	2024-12-02 10:00:00	2024-12-03 10:00:00
The rental durations in days would be:

Rental 1: 1 day
Rental 2: 3 days
Rental 3: 1 day
The result of the query would be:

average_rental_duration
1.6667
This query will return the average rental duration in days for all the rentals in the Sakila database.

String Functions:

Question 3:

Display the first name and last name of customers in uppercase.

Hint: Use the UPPER () function.
To display the first name and last name of customers in uppercase, you can use the UPPER() function. The UPPER() function converts all letters in the specified string to uppercase.

SQL Query to Display First Name and Last Name of Customers in Uppercase:
sql
Copy code
SELECT UPPER(first_name) AS first_name_uppercase,
       UPPER(last_name) AS last_name_uppercase
FROM customer;
Explanation:
UPPER(first_name): Converts the first_name of each customer to uppercase.
UPPER(last_name): Converts the last_name of each customer to uppercase.
AS first_name_uppercase and AS last_name_uppercase: Renames the columns for readability.
FROM customer: Specifies the customer table from which to retrieve the data.
Example Output:
Assuming the customer table contains the following data:

customer_id	first_name	last_name
1	John	Doe
2	Jane	Smith
3	Alice	Johnson
The result of the query would be:

first_name_uppercase	last_name_uppercase
JOHN	DOE
JANE	SMITH
ALICE	JOHNSON
This query will return the first name and last name of each customer, both in uppercase.

Question 4:

Extract the month from the rental date and display it alongside the rental ID.

Hint: Employ the MONTH() function.
To extract the month from the rental_date and display it alongside the rental_id, you can use the MONTH() function. The MONTH() function extracts the month as a number from a given date.

SQL Query to Extract the Month from the Rental Date and Display It with the Rental ID:
sql
Copy code
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;
Explanation:
MONTH(rental_date): Extracts the month from the rental_date. The result will be a number between 1 (January) and 12 (December).
AS rental_month: Renames the extracted month column for clarity.
FROM rental: Specifies the rental table from which to retrieve the data.
Example Output:
Assuming the rental table contains the following data:

rental_id	rental_date
1	2024-12-01 10:00:00
2	2024-11-15 12:00:00
3	2024-12-10 14:00:00
The result of the query would be:

rental_id	rental_month
1	12
2	11
3	12
This query will return the rental_id along with the month extracted from the rental_date for each rental.

GROUP BY:
Question 5:

Retrieve the count of rentals for each customer (display customer ID and the count of rentals).

Hint: Use COUNT () in conjunction with GROUP BY.
To retrieve the count of rentals for each customer, you can use the COUNT() function in conjunction with the GROUP BY clause. This will allow you to group the results by customer_id and count the number of rentals for each customer.

SQL Query to Retrieve the Count of Rentals for Each Customer:
sql
Copy code
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;
Explanation:
COUNT(*): Counts the number of rentals for each customer.
AS rental_count: Renames the count column to rental_count for readability.
FROM rental: Specifies the rental table from which to retrieve the data.
GROUP BY customer_id: Groups the results by customer_id so that the count is calculated for each customer individually.
Example Output:
Assuming the rental table contains the following data:

rental_id	rental_date	customer_id	inventory_id	return_date
1	2024-12-01 10:00:00	1	101	2024-12-02 10:00:00
2	2024-12-01 11:00:00	2	102	2024-12-02 11:00:00
3	2024-12-02 10:00:00	1	103	2024-12-03 10:00:00
4	2024-12-02 12:00:00	3	104	2024-12-03 12:00:00
5	2024-12-03 10:00:00	2	105	2024-12-04 10:00:00
6	2024-12-03 11:00:00	1	106	2024-12-04 11:00:00
The result of the query would be:

customer_id	rental_count
1	3
2	2
3	1
This query will return the customer_id and the corresponding count of rentals made by each customer.

Question 6:

Find the total revenue generated by each store.

Hint: Combine SUM() and GROUP BY.
To find the total revenue generated by each store, you can combine the SUM() function to calculate the total revenue and use the GROUP BY clause to group the results by store.

Assuming there is a store table, a rental table, and a payment table (which contains the payment details including the amount), the revenue generated by each store can be calculated by summing up the payment amounts and grouping by store.

SQL Query to Find the Total Revenue Generated by Each Store:
sql
Copy code
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id;

Question 7:

Determine the total number of rentals for each category of movies.

Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
To determine the total number of rentals for each category of movies, you will need to join the film_category, film, and rental tables. After joining these tables, you can use the COUNT() function to calculate the total number of rentals for each category, and GROUP BY to group the results by category.

SQL Query to Determine the Total Number of Rentals for Each Category:
sql
Copy code
SELECT c.category_id, ca.name AS category_name, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category ca ON fc.category_id = ca.category_id
GROUP BY c.category_id, ca.name;

Question 8:

Find the average rental rate of movies in each language.

Hint: JOIN film and language tables, then use AVG () and GROUP BY.
To find the average rental rate of movies in each language, you need to join the film and language tables. After joining these tables, you can use the AVG() function to calculate the average rental rate for each language, and GROUP BY to group the results by language.

SQL Query to Find the Average Rental Rate of Movies in Each Language:
sql
Copy code
SELECT l.language_id, l.name AS language_name, AVG(f.rental_rate) AS average_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.language_id, l.name;

Joins
Questions 9 -

Display the title of the movie, customer s first name, and last name who rented it.

Hint: Use JOIN between the film, inventory, rental, and customer tables.
To display the title of the movie, the customer's first name, and last name who rented it, you will need to join the film, inventory, rental, and customer tables. This will allow you to retrieve the movie title along with the customer details for each rental.

SQL Query to Display the Movie Title, Customer's First Name, and Last Name:
sql
Copy code
SELECT f.title, c.first_name, c.last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;

Question 10:

Retrieve the names of all actors who have appeared in the film "Gone with the Wind."

Hint: Use JOIN between the film actor, film, and actor tables.
To retrieve the names of all actors who have appeared in the film "Gone with the Wind," you need to join the film_actor, film, and actor tables. This will allow you to find the actors associated with the specific film.

SQL Query to Retrieve the Names of All Actors Who Appeared in "Gone with the Wind":
sql
Copy code
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';
Explanation:
a.first_name, a.last_name: Retrieves the first and last names of the actors from the actor table.
FROM actor a: Specifies the actor table from which to retrieve the actor details.
JOIN film_actor fa ON a.actor_id = fa.actor_id: Joins the actor table with the film_actor table using actor_id to link actors with the films they appeared in.
JOIN film f ON fa.film_id = f.film_id: Joins the film_actor table with the film table using film_id to link the actors with specific films.
WHERE f.title = 'Gone with the Wind': Filters the results to only include actors from the film "Gone with the Wind".
Example Output:
Assuming the relevant tables have the following data:

first_name	last_name
Clark	Gable
Vivien	Leigh
The result of the query would display the actors who appeared in "Gone with the Wind."

This query will return the names of all actors who have appeared in the film "Gone with the Wind" in the Sakila database.

Question 11:

Retrieve the customer names along with the total amount they've spent on rentals.

Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
To retrieve the customer names along with the total amount they've spent on rentals, you need to join the customer, payment, and rental tables. After joining, you can use the SUM() function to calculate the total amount spent by each customer, and use the GROUP BY clause to group the results by customer.

SQL Query to Retrieve the Customer Names and Total Amount Spent on Rentals:
sql
Copy code
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id;

Question 12:

List the titles of movies rented by each customer in a particular city (e.g., 'London').

Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
To list the titles of movies rented by each customer in a particular city (e.g., 'London'), you need to join the customer, address, city, rental, inventory, and film tables. After joining these tables, you can use the GROUP BY clause to group the results by customer and city.

SQL Query to List the Titles of Movies Rented by Each Customer in a Specific City:
sql
Copy code
SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
ORDER BY c.first_name, c.last_name, f.title;

Advanced Joins and GROUP BY:
Question 13:

Display the top 5 rented movies along with the number of times they've been rented.

Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
To display the top 5 rented movies along with the number of times they've been rented, you need to join the film, inventory, and rental tables. Then, you can use the COUNT() function to count the number of rentals for each movie and GROUP BY to group the results by film. Finally, you can use LIMIT to restrict the results to the top 5 movies.

SQL Query to Display the Top 5 Rented Movies Along with the Number of Times They've Been Rented:
sql
Copy code
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY rental_count DESC
LIMIT 5;

Question 14:

Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).

Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
To determine the customers who have rented movies from both stores (store ID 1 and store ID 2), you will need to join the rental, inventory, and customer tables. Then, you can use COUNT() and GROUP BY to count the number of distinct store IDs for each customer. Finally, you will filter to show only those customers who have rented from both store IDs.

SQL Query to Determine Customers Who Have Rented Movies from Both Stores (Store ID 1 and Store ID 2):
sql
Copy code
SELECT c.first_name, c.last_name, c.customer_id
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id
HAVING COUNT(DISTINCT i.store_id) = 2;

Windows Function:
1. Rank the customers based on the total amount they've spent on rentals.
To rank customers based on the total amount they've spent on rentals, we will need to join the customer, rental, and payment tables. After calculating the total amount spent by each customer, we can rank them using the RANK() window function, which assigns a rank to each customer based on their total amount spent, with ties receiving the same rank.

SQL Query to Rank Customers Based on the Total Amount They've Spent on Rentals:
sql
Copy code
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS rank
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id
ORDER BY rank;

2. Calculate the cumulative revenue generated by each film over time.
To calculate the cumulative revenue generated by each film over time, we can use the SUM() window function with the OVER() clause. This allows us to calculate a running total of the revenue for each film based on the order of the rental dates.

SQL Query to Calculate the Cumulative Revenue Generated by Each Film:
sql
Copy code
SELECT f.title, r.rental_date, SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY r.rental_date) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY f.film_id, r.rental_date;

3. Determine the average rental duration for each film, considering films with similar lengths.
To determine the average rental duration for each film, while considering films with similar lengths, you can group the films by their length and then calculate the average rental duration for films within each length group. This will allow you to analyze the rental duration for films with similar lengths.

Here’s how you can achieve this:

SQL Query to Determine the Average Rental Duration for Each Film, Considering Films with Similar Lengths:
sql
Copy code
SELECT f.title, f.length, AVG(r.rental_duration) AS avg_rental_duration
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.length, f.title
ORDER BY f.length, avg_rental_duration DESC;

4. Identify the top 3 films in each category based on their rental counts.
o identify the top 3 films in each category based on their rental counts, you will need to join several tables: film_category, category, film, inventory, and rental. By using COUNT() to determine the rental counts, you can rank the films within each category.

To achieve this, we'll use a combination of JOIN statements, COUNT(), and the ROW_NUMBER() window function to rank films within each category.

SQL Query to Identify the Top 3 Films in Each Category Based on Rental Counts:
sql
Copy code
WITH ranked_films AS (
    SELECT c.name AS category_name,
           f.title AS film_title,
           COUNT(r.rental_id) AS rental_count,
           ROW_NUMBER() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rank
    FROM film_category fc
    JOIN category c ON fc.category_id = c.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.category_id, f.film_id
)
SELECT category_name, film_title, rental_count
FROM ranked_films
WHERE rank <= 3
ORDER BY category_name, rank;

5. Calculate the difference in rental counts between each customer's total rentals and the average rentals

across all customers.
To calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers, we will need to:

Calculate the total rentals for each customer.
Calculate the average number of rentals across all customers.
Subtract the average rental count from each customer's total rental count to find the difference.
This involves two main steps:

Using COUNT() to get the total rentals for each customer.
Using a subquery or AVG() window function to calculate the average rental count across all customers.
SQL Query to Calculate the Difference in Rental Counts:
sql
Copy code
WITH customer_rentals AS (
    SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    GROUP BY c.customer_id
),
average_rentals AS (
    SELECT AVG(total_rentals) AS avg_rentals
    FROM customer_rentals
)
SELECT cr.first_name, cr.last_name, cr.total_rentals,
       cr.total_rentals - ar.avg_rentals AS rental_difference
FROM customer_rentals cr, average_rentals ar
ORDER BY rental_difference DESC;

6. Find the monthly revenue trend for the entire rental store over time.
To find the monthly revenue trend for the entire rental store over time, we need to calculate the total revenue generated each month. Revenue is typically stored in the payment table, where each payment is associated with a rental. We can group the results by month and year, and then sum the amount field from the payment table to calculate the total revenue for each month.

We can use the YEAR() and MONTH() functions to extract the year and month from the payment_date field, and then group by these values.

SQL Query to Find the Monthly Revenue Trend:
sql
Copy code
SELECT
    YEAR(p.payment_date) AS year,
    MONTH(p.payment_date) AS month,
    SUM(p.amount) AS total_revenue
FROM payment p
GROUP BY YEAR(p.payment_date), MONTH(p.payment_date)
ORDER BY year, month;

7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
To identify customers whose total spending on rentals falls within the top 20% of all customers, we need to calculate the total spending for each customer and then determine the threshold that separates the top 20% of customers from the rest.

To achieve this, we can follow these steps:

Calculate the total spending for each customer by summing the amounts from the payment table.
Determine the 80th percentile (the threshold above which the top 20% of customers fall).
Select customers whose total spending is greater than or equal to this 80th percentile.
SQL Query to Identify the Customers in the Top 20% Based on Total Spending:
sql
Copy code
WITH customer_spending AS (
    SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spending
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
),
percentile_80 AS (
    SELECT PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY total_spending DESC) AS spending_threshold
    FROM customer_spending
)
SELECT cs.first_name, cs.last_name, cs.total_spending
FROM customer_spending cs, percentile_80 p
WHERE cs.total_spending >= p.spending_threshold
ORDER BY cs.total_spending DESC;

8. Calculate the running total of rentals per category, ordered by rental count.
To calculate the running total of rentals per category ordered by rental count, we need to:

Join the necessary tables (film_category, category, inventory, and rental).
Count the rentals for each category.
Use a window function (SUM() OVER) to compute the cumulative (running) total of rentals, ordered by rental count within each category.
Here's how we can write the SQL query to achieve this:

SQL Query to Calculate Running Total of Rentals per Category:
sql
Copy code
WITH category_rentals AS (
    SELECT
        c.category_id,
        c.name AS category_name,
        f.title AS film_title,
        COUNT(r.rental_id) AS rental_count
    FROM film_category fc
    JOIN category c ON fc.category_id = c.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.category_id, f.film_id, c.name
)
SELECT
    category_name,
    film_title,
    rental_count,
    SUM(rental_count) OVER (PARTITION BY category_name ORDER BY rental_count DESC) AS running_total
FROM category_rentals
ORDER BY category_name, rental_count DESC;

9. Find the films that have been rented less than the average rental count for their respective categories.
o find the films that have been rented less than the average rental count for their respective categories, we need to:

Calculate the total rental count for each film within each category.
Calculate the average rental count for each category.
Compare the rental count of each film to the average rental count of its respective category and filter out films rented less than the average.
We will use subqueries or Common Table Expressions (CTEs) to calculate both the total rental counts per film and the average rental count per category.

SQL Query to Find Films Rented Less Than the Average Rental Count for Their Categories:
sql
Copy code
WITH category_rentals AS (
    SELECT
        c.category_id,
        c.name AS category_name,
        f.title AS film_title,
        COUNT(r.rental_id) AS rental_count
    FROM film_category fc
    JOIN category c ON fc.category_id = c.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.category_id, f.film_id, c.name
),
category_avg_rentals AS (
    SELECT
        category_id,
        AVG(rental_count) AS avg_rental_count
    FROM category_rentals
    GROUP BY category_id
)
SELECT
    cr.category_name,
    cr.film_title,
    cr.rental_count,
    car.avg_rental_count
FROM category_rentals cr
JOIN category_avg_rentals car ON cr.category_id = car.category_id
WHERE cr.rental_count < car.avg_rental_count
ORDER BY cr.category_name, cr.rental_count;

10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.
To identify the top 5 months with the highest revenue, we need to:

Calculate the total revenue for each month from the payment table by summing the amount column.
Group the results by month and year, using the YEAR() and MONTH() functions to extract the respective values from the payment_date.
Order the results by total revenue in descending order and limit the results to the top 5 months.
SQL Query to Identify the Top 5 Months with the Highest Revenue:
sql
Copy code
SELECT
    YEAR(p.payment_date) AS year,
    MONTH(p.payment_date) AS month,
    SUM(p.amount) AS total_revenue
FROM payment p
GROUP BY YEAR(p.payment_date), MONTH(p.payment_date)
ORDER BY total_revenue DESC
LIMIT 5;

Normalisation & CTE
1. First Normal Form (1NF):

 a. Identify a table in the Sakila database that violates 1NF. Explain how you

 would normalize it to achieve 1NF.
First Normal Form (1NF) Overview:
A table is said to be in First Normal Form (1NF) if it meets the following conditions:

Atomicity: All columns in the table should contain atomic (indivisible) values. This means that each column should contain only one value per row.
Uniqueness: Each row must be unique. No duplicate rows are allowed.
No Repeating Groups: There should be no repeating groups or arrays in any column.
Table in the Sakila Database that Violates 1NF:
One table that can potentially violate 1NF is the actor table, which contains multiple film_id values in a single row for an actor (if we consider a potential violation like storing multiple film IDs in a single column). In the Sakila database, this would be managed through a junction table (film_actor), so the problem might arise in a different table or through improper design (such as multiple values being stored in a single column).

However, for the purpose of explanation, let’s assume there’s a non-normalized table where a column (such as actor_film_ids) is storing multiple film IDs in a single cell. We will normalize it to 1NF.

Example: Violation of 1NF
Assume a actor_film_violated table where an actor can have multiple film IDs in a single column:

actor_film_violated (Non-1NF Example)
actor_id	actor_name	actor_film_ids
1	Brad Pitt	1, 2, 3
2	Angelina Jolie	4, 5
Here, the actor_film_ids column contains multiple values (film IDs) in a single column, which violates 1NF because the values are not atomic.

How to Normalize to 1NF:
To achieve First Normal Form (1NF), we need to ensure that:

Each film ID is stored in a separate row.
No multiple values are stored in a single column.
Solution:
We can normalize this table by creating a new row for each film ID that an actor is associated with.

Normalized actor_film Table (1NF)
actor_id	actor_name	film_id
1	Brad Pitt	1
1	Brad Pitt	2
1	Brad Pitt	3
2	Angelina Jolie	4
2	Angelina Jolie	5
Now, each row represents a single actor_id and film_id combination, ensuring that the table is in 1NF.

SQL Code to Normalize the Table:
sql
Copy code
-- Create the normalized table 'actor_film' that meets 1NF
CREATE TABLE actor_film (
    actor_id INT,
    actor_name VARCHAR(100),
    film_id INT
);

-- Insert data from the violated table into the normalized 'actor_film' table
-- (assuming the 'actor_film_violated' table had the data with multiple film_ids)
INSERT INTO actor_film (actor_id, actor_name, film_id)
SELECT actor_id, actor_name, UNNEST(string_to_array(actor_film_ids, ','))::INT AS film_id
FROM actor_film_violated;

-- Drop the violated table if no longer needed
DROP TABLE actor_film_violated;
Explanation:
string_to_array(actor_film_ids, ','): This function converts the comma-separated actor_film_ids into an array.
UNNEST(): This function converts each element of the array into a separate row.
Normalization: The new actor_film table stores each actor_id and film_id pair on a separate row, ensuring compliance with 1NF.

2. Second Normal Form (2NF):

 a. Choose a table in Sakila and describe how you would determine whether it is in 2NF.

 If it violates 2NF, explain the steps to normalize it.
 Second Normal Form (2NF) Overview:
A table is in Second Normal Form (2NF) if:

It is in 1NF: The table must already meet the conditions of First Normal Form.
No Partial Dependency: All non-key attributes must depend on the entire primary key. This means that there should be no non-key attribute that depends only on a part of a composite primary key.
Checking for 2NF:
To determine whether a table is in 2NF, follow these steps:

Ensure the table is in 1NF: Check that all columns contain atomic values and there are no repeating groups.
Examine the primary key: If the table has a composite primary key (a primary key made up of more than one column), check if there are any non-key columns that depend only on part of the primary key.
Look for partial dependencies: Identify if any non-key attribute is dependent on only part of the primary key. If such dependencies exist, the table violates 2NF.
Example: film_actor Table in Sakila Database
The film_actor table in the Sakila database is a typical example of a table that can potentially violate 2NF if it has a composite primary key. It contains the relationship between films and actors, and its primary key is typically a combination of film_id and actor_id.

film_actor Table (Composite Primary Key Example)
film_id	actor_id	actor_name	film_title
1	1	Brad Pitt	Fight Club
1	2	Edward Norton	Fight Club
2	1	Brad Pitt	Se7en
2	3	Morgan Freeman	Se7en
Primary Key: film_id, actor_id (Composite key).

Steps to Determine if the Table Violates 2NF:
In 1NF: The film_actor table is already in 1NF because there are no repeating groups or non-atomic values.
Composite Primary Key: The table uses a composite key (film_id + actor_id).
Partial Dependency: We need to check if any non-key attribute is dependent on just part of the composite key.
actor_name depends only on actor_id, not on the entire composite key (film_id, actor_id).
film_title depends only on film_id, not on the entire composite key.
Therefore, actor_name and film_title are partially dependent on parts of the primary key.
Violation of 2NF:
The non-key attributes actor_name and film_title violate 2NF because they are partially dependent on part of the primary key (i.e., actor_id for actor_name and film_id for film_title).
Partial Dependency: Since the primary key is composite (film_id, actor_id), the actor_name should only depend on actor_id, and film_title should depend on film_id. This violates 2NF.
Steps to Normalize the Table to 2NF:
To normalize the film_actor table into 2NF, we need to eliminate the partial dependencies by splitting the table into two tables:

Create a separate table for actors: This table will store the actor's information, and it will be keyed by actor_id.
Create a separate table for films: This table will store the film's information, and it will be keyed by film_id.
Modify film_actor: The film_actor table will now only store the relationship between film_id and actor_id, with no redundant information (i.e., no actor_name or film_title).
Step 1: Create actors Table (Normalization of actor_name)
sql
Copy code
CREATE TABLE actors (
    actor_id INT PRIMARY KEY,
    actor_name VARCHAR(100)
);

-- Insert data into the actors table
INSERT INTO actors (actor_id, actor_name)
SELECT DISTINCT actor_id, actor_name
FROM film_actor;
Step 2: Create films Table (Normalization of film_title)
sql
Copy code
CREATE TABLE films (
    film_id INT PRIMARY KEY,
    film_title VARCHAR(255)
);

-- Insert data into the films table
INSERT INTO films (film_id, film_title)
SELECT DISTINCT film_id, film_title
FROM film_actor;
Step 3: Modify film_actor Table (Eliminate Partial Dependencies)
sql
Copy code
CREATE TABLE film_actor (
    film_id INT,
    actor_id INT,
    PRIMARY KEY (film_id, actor_id),
    FOREIGN KEY (film_id) REFERENCES films(film_id),
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id)
);


3. Third Normal Form (3NF):

 a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies

 present and outline the steps to normalize the table to 3NF.
 A table is in Third Normal Form (3NF) if:

It is in 2NF: The table must first meet the conditions of Second Normal Form (2NF).
No Transitive Dependency: There should be no transitive dependencies. This means that non-key attributes should not depend on other non-key attributes.
What is a Transitive Dependency?
A transitive dependency occurs when a non-key attribute depends on another non-key attribute, which in turn depends on the primary key. For example, if A -> B and B -> C, then A -> C is a transitive dependency. This violates 3NF because C depends on A indirectly through B, even though C is not a part of the primary key.

Example of a Table in the Sakila Database that Violates 3NF:
Consider the payment table in the Sakila database. It contains information about payments made by customers for rentals. The schema of this table includes attributes like payment_id, customer_id, staff_id, amount, and store_id, as well as related information such as the staff_name.

payment Table (Potential Violation of 3NF)
payment_id	customer_id	staff_id	amount	store_id	staff_name
1	1	1	5.00	1	John Doe
2	2	1	10.00	1	John Doe
3	3	2	15.00	2	Jane Smith
Primary Key: payment_id

Transitive Dependency:
In the payment table:

The staff_name depends on staff_id.
The staff_id depends on the payment_id indirectly because staff_id is a part of the payment entry.
Thus, there is a transitive dependency between staff_name and payment_id through staff_id.

Transitive Dependency: payment_id -> staff_id -> staff_name
This violates 3NF because staff_name is a non-key attribute that depends on another non-key attribute (staff_id), which is not the primary key.

Steps to Normalize the payment Table to 3NF:
To bring the payment table into 3NF, we need to eliminate the transitive dependency by removing the staff_name from the payment table. We can do this by creating a separate table for staff information and referencing it with a foreign key in the payment table.

Step 1: Create a New staff Table
We will create a new table staff that contains information about the staff, such as their staff_id and staff_name.

sql
Copy code
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(100)
);

-- Insert data into the staff table
INSERT INTO staff (staff_id, staff_name)
SELECT DISTINCT staff_id, staff_name
FROM payment;
Step 2: Modify the payment Table
We will now modify the payment table to remove the staff_name column. The staff_id will remain in the payment table as a foreign key referencing the new staff table.

sql
Copy code
-- Modify the payment table to remove staff_name and make it normalized
ALTER TABLE payment
DROP COLUMN staff_name;

-- Add the foreign key constraint to ensure referential integrity
ALTER TABLE payment
ADD CONSTRAINT fk_staff_id FOREIGN KEY (staff_id) REFERENCES staff(staff_id);
Step 3: Final Structure
Now, the structure of the tables will be:

staff Table (Contains staff information):

staff_id	staff_name
1	John Doe
2	Jane Smith
payment Table (Modified to remove transitive dependency):

payment_id	customer_id	staff_id	amount	store_id
1	1	1	5.00	1
2	2	1	10.00	1
3	3	2	15.00	2

4. Normalization Process:

 a. Take a specific table in Sakila and guide through the process of normalizing it from the initial

 unnormalized form up to at least 2NF.
 Normalization Process from Unnormalized Form (UNF) to 2NF
Normalization is the process of organizing data in a way that reduces redundancy and dependency. The goal is to divide a database into smaller, well-structured tables to ensure data integrity.

We'll go through the normalization process for a table from Unnormalized Form (UNF) to Second Normal Form (2NF), using an example from the Sakila database.

Let's use a table called rental_details (a hypothetical table based on existing relationships in the Sakila database) that may contain rental transaction details, customer information, and film information in an unnormalized format.

Hypothetical rental_details Table (Unnormalized Form)
rental_id	customer_id	customer_name	film_id	film_title	rental_date	rental_duration	amount
1	1	John Doe	1	Fight Club	2024-01-01	3	5.00
2	2	Jane Smith	2	Se7en	2024-01-02	5	7.00
3	1	John Doe	3	The Matrix	2024-01-03	2	4.00
4	3	Robert Brown	1	Fight Club	2024-01-04	3	5.00
Step 1: Unnormalized Form (UNF)
In the unnormalized form (UNF), data might contain repeated or redundant information, such as customer names and film titles being stored multiple times. There are several problems in this form:

Redundant Data: Customer names and film titles are repeated for each rental transaction.
Update Anomalies: If a customer's name changes, we would need to update every occurrence of the customer name in the table.
Deletion Anomalies: Deleting a rental transaction could result in losing customer or film information.
Step 2: Convert to 1st Normal Form (1NF)
To bring the table to First Normal Form (1NF), we need to ensure that:

All columns contain atomic values (no repeating groups).
There are no arrays or lists of values in any column.
Transformation to 1NF:
We already have atomic values (e.g., no arrays or repeating groups), but we still have redundant data. The table contains multiple occurrences of the same customer_name and film_title. To achieve 1NF, we can separate the customer information and film information into different tables.

However, at this stage, we still retain redundant data.

Separate data into multiple tables: Move customer and film information to their respective tables.
Create relationships between tables using primary keys.
Step 3: Convert to 2nd Normal Form (2NF)
To achieve Second Normal Form (2NF), the table must:

Be in 1NF: We have already met this condition.
Eliminate partial dependencies: There should be no non-key attributes that depend on part of the primary key (i.e., no partial dependencies).
In our case, the primary key could be a composite key consisting of rental_id and customer_id, or we could make rental_id the primary key (if we treat each rental uniquely).

We have the following non-key attributes:

customer_name: This depends on customer_id but not on rental_id.
film_title: This depends on film_id but not on rental_id.
We have partial dependencies because both customer_name and film_title depend on parts of the primary key (i.e., customer_id and film_id), which violates 2NF.

Step 4: Normalize to 2NF
To eliminate partial dependencies, we need to break the table into smaller tables where:

Customer information is stored separately in a customers table.
Film information is stored separately in a films table.
The rental transaction information is stored in the rentals table, which references the customers and films tables.
2NF Normalized Tables:
Customers Table (to store customer information):
sql
Copy code
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);
Films Table (to store film information):
sql
Copy code
CREATE TABLE films (
    film_id INT PRIMARY KEY,
    film_title VARCHAR(255)
);
Rentals Table (stores the rental transactions):
sql
Copy code
CREATE TABLE rentals (
    rental_id INT PRIMARY KEY,
    rental_date DATE,
    rental_duration INT,
    amount DECIMAL(10, 2),
    customer_id INT,
    film_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (film_id) REFERENCES films(film_id)
);
Explanation:
The customers table stores only customer-related data (no redundant customer data in the rentals table).
The films table stores only film-related data (no redundant film data in the rentals table).
The rentals table now contains only the rental-specific data (such as rental_date, rental_duration, and amount), and references the customer_id and film_id to establish the relationship.
Resulting Tables in 2NF:
customers Table:
customer_id	customer_name
1	John Doe
2	Jane Smith
3	Robert Brown
films Table:
film_id	film_title
1	Fight Club
2	Se7en
3	The Matrix
rentals Table:
rental_id	rental_date	rental_duration	amount	customer_id	film_id
1	2024-01-01	3	5.00	1	1
2	2024-01-02	5	7.00	2	2
3	2024-01-03	2	4.00	1	3
4	2024-01-04	3	5.00	3	1

5. CTE Basics:

 a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they

 have acted in from the actor and film_actor tables.
 To retrieve a distinct list of actor names and the number of films they have acted in using a Common Table Expression (CTE) from the actor and film_actor tables in the Sakila database, we can follow these steps:

CTE Query:
sql
Copy code
WITH ActorFilmCount AS (
    SELECT
        a.actor_id,
        a.first_name,
        a.last_name,
        COUNT(fa.film_id) AS film_count
    FROM
        actor a
    JOIN
        film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY
        a.actor_id, a.first_name, a.last_name
)
SELECT
    first_name,
    last_name,
    film_count
FROM
    ActorFilmCount;
Explanation:
WITH ActorFilmCount AS: This creates a CTE named ActorFilmCount. The CTE will hold the intermediate result of the query.
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count: In the CTE, we select the actor's ID, first name, last name, and the count of films they have acted in. This is done by counting the film_id from the film_actor table, which links actors to films.
FROM actor a JOIN film_actor fa ON a.actor_id = fa.actor_id: We join the actor table with the film_actor table based on the actor_id to get the films associated with each actor.
GROUP BY a.actor_id, a.first_name, a.last_name: This groups the result by the actor's ID, first name, and last name to ensure that we get a distinct list of actors.
SELECT first_name, last_name, film_count FROM ActorFilmCount: Finally, we select the first name, last name, and the number of films (film_count) from the CTE and display the results.
Result:
The query will return a list of actors along with the number of films they have acted in, where each actor appears only once in the result.

Example output:

first_name	last_name	film_count
Angelina	Jolie	10
Brad	Pitt	15
Tom	Hanks	20
...	...	...
This query uses the power of CTEs to break the logic into an easily understandable structure and calculates the number of films for each actor.

6. CTE with Joins:

 a. Create a CTE that combines information from the film and language tables to display the film title,

 language name, and rental rate.
 To create a Common Table Expression (CTE) that combines information from the film and language tables to display the film title, language name, and rental rate, you can write the following SQL query:

CTE Query:
sql
Copy code
WITH FilmLanguageDetails AS (
    SELECT
        f.film_id,
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM
        film f
    JOIN
        language l ON f.language_id = l.language_id
)
SELECT
    film_title,
    language_name,
    rental_rate
FROM
    FilmLanguageDetails;
Explanation:
WITH FilmLanguageDetails AS: This creates a CTE named FilmLanguageDetails, which contains the intermediate result of joining the film and language tables.
SELECT f.film_id, f.title AS film_title, l.name AS language_name, f.rental_rate: In the CTE, we select the film_id, title (renamed as film_title), language name (from the language table, renamed as language_name), and the rental_rate from the film table.
FROM film f JOIN language l ON f.language_id = l.language_id: We join the film table with the language table on the language_id column to retrieve the language associated with each film.
SELECT film_title, language_name, rental_rate FROM FilmLanguageDetails: Finally, we select the columns from the CTE and display the results.
Result:
This query will return the film title, language name, and rental rate for each film, with the data joined from the film and language tables.

Example output:

film_title	language_name	rental_rate
A Beautiful Mind	English	2.99
The Matrix	English	2.99
Se7en	English	2.99
...	...	...
This query effectively uses the CTE to combine and display the relevant information from the two tables (film and language).

c\ CTE for Aggregation:

 a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments)

 from the customer and payment tables.
 To write a query using a Common Table Expression (CTE) to find the total revenue generated by each customer (sum of payments) from the customer and payment tables in the Sakila database, you can follow the query below:

CTE Query:
sql
Copy code
WITH CustomerRevenue AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_revenue
    FROM
        customer c
    JOIN
        payment p ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name
)
SELECT
    first_name,
    last_name,
    total_revenue
FROM
    CustomerRevenue
ORDER BY
    total_revenue DESC;
Explanation:
WITH CustomerRevenue AS: This creates a CTE named CustomerRevenue to hold the intermediate results of the total revenue per customer.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_revenue: In the CTE, we select the customer_id, first_name, last_name, and the total revenue for each customer by summing the amount from the payment table.
FROM customer c JOIN payment p ON c.customer_id = p.customer_id: We join the customer table with the payment table on customer_id to aggregate the payments made by each customer.
GROUP BY c.customer_id, c.first_name, c.last_name: The grouping is done by customer_id, first_name, and last_name to ensure we calculate the total revenue for each customer.
SELECT first_name, last_name, total_revenue FROM CustomerRevenue ORDER BY total_revenue DESC: Finally, we select the first_name, last_name, and total_revenue from the CTE and order the results by total_revenue in descending order.
Result:
This query will return a list of customers along with the total revenue generated by each customer from their payments.

Example output:

first_name	last_name	total_revenue
John	Doe	200.00
Jane	Smith	150.00
Alice	Johnson	120.00
...	...	...
The query uses a CTE to calculate the total amount spent by each customer, which is useful for understanding customer spending behavior in a clear and organized manner.

8 CTE with Window Functions:

 a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
To utilize a Common Table Expression (CTE) with a window function to rank films based on their rental duration from the film table, we can use the RANK() or ROW_NUMBER() window function, which assigns a rank to each film based on the rental duration.

CTE Query:
sql
Copy code
WITH FilmRentalRank AS (
    SELECT
        f.film_id,
        f.title AS film_title,
        f.rental_duration,
        RANK() OVER (ORDER BY f.rental_duration DESC) AS rental_rank
    FROM
        film f
)
SELECT
    film_title,
    rental_duration,
    rental_rank
FROM
    FilmRentalRank
ORDER BY
    rental_rank;
Explanation:
WITH FilmRentalRank AS: This creates a CTE named FilmRentalRank to hold the intermediate results of the ranking based on rental duration.
SELECT f.film_id, f.title AS film_title, f.rental_duration: In the CTE, we select the film_id, title (renamed as film_title), and rental_duration from the film table.
RANK() OVER (ORDER BY f.rental_duration DESC) AS rental_rank: This is the window function that assigns a rank to each film based on its rental duration. The RANK() function orders the films by rental_duration in descending order (longer rental durations are ranked higher). You could also use ROW_NUMBER() if you prefer unique sequential numbers rather than ranks that may have ties.
SELECT film_title, rental_duration, rental_rank FROM FilmRentalRank: After defining the CTE, we select the film_title, rental_duration, and the computed rental_rank.
ORDER BY rental_rank: Finally, the films are ordered by their rank so that the films with the highest rental durations appear first.

9 CTE and Filtering:

 a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the

 customer table to retrieve additional customer details.
 To create a Common Table Expression (CTE) that lists customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details, you can use the following query.

CTE Query:
sql
Copy code
WITH CustomerRentalCount AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        COUNT(r.rental_id) AS rental_count
    FROM
        customer c
    JOIN
        rental r ON c.customer_id = r.customer_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name
    HAVING
        COUNT(r.rental_id) > 2
)
SELECT
    crc.customer_id,
    crc.first_name,
    crc.last_name,
    crc.rental_count,
    c.email,
    c.address_id
FROM
    CustomerRentalCount crc
JOIN
    customer c ON crc.customer_id = c.customer_id;
Explanation:
WITH CustomerRentalCount AS: This creates a CTE named CustomerRentalCount, which will hold the result of customers who have made more than two rentals.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS rental_count: In the CTE, we select the customer_id, first_name, last_name, and the count of rental_id from the rental table to calculate the number of rentals each customer has made.
FROM customer c JOIN rental r ON c.customer_id = r.customer_id: We join the customer table with the rental table on the customer_id to get the rentals made by each customer.
GROUP BY c.customer_id, c.first_name, c.last_name: We group the results by customer_id, first_name, and last_name to calculate the rental count for each customer.
HAVING COUNT(r.rental_id) > 2: This filters out the customers who have made more than two rentals.
SELECT crc.customer_id, crc.first_name, crc.last_name, crc.rental_count, c.email, c.address_id: After defining the CTE, we select the customer_id, first_name, last_name, rental_count, email, and address_id from the CTE and customer table.
JOIN customer c ON crc.customer_id = c.customer_id: We join the CTE with the customer table on customer_id to retrieve additional details like email and address_id for the customers.

10 CTE for Date Calculations:

 a. Write a query using a CTE to find the total number of rentals made each month, considering the

 rental_date from the rental table.
 To write a query using a Common Table Expression (CTE) to find the total number of rentals made each month based on the rental_date from the rental table, you can use the MONTH() and YEAR() functions to extract the month and year from the rental date and then aggregate the number of rentals.

CTE Query:
sql
Copy code
WITH MonthlyRentalCounts AS (
    SELECT
        YEAR(r.rental_date) AS rental_year,
        MONTH(r.rental_date) AS rental_month,
        COUNT(r.rental_id) AS rental_count
    FROM
        rental r
    GROUP BY
        YEAR(r.rental_date), MONTH(r.rental_date)
)
SELECT
    rental_year,
    rental_month,
    rental_count
FROM
    MonthlyRentalCounts
ORDER BY
    rental_year DESC, rental_month DESC;
Explanation:
WITH MonthlyRentalCounts AS: This creates a CTE named MonthlyRentalCounts, which will hold the results of the total number of rentals made in each month.
SELECT YEAR(r.rental_date) AS rental_year, MONTH(r.rental_date) AS rental_month: The YEAR() and MONTH() functions are used to extract the year and month from the rental_date.
COUNT(r.rental_id) AS rental_count: This counts the number of rentals made in each month.
FROM rental r: This selects from the rental table.
GROUP BY YEAR(r.rental_date), MONTH(r.rental_date): This groups the results by year and month so that we can calculate the rental counts for each month.
SELECT rental_year, rental_month, rental_count FROM MonthlyRentalCounts ORDER BY rental_year DESC, rental_month DESC: After defining the CTE, we select the rental_year, rental_month, and the total rental_count from the CTE and order the results by rental_year and rental_month in descending order, showing the most recent months first.

11 CTE and Self-Join:

 a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film

 together, using the film_actor table.
 To create a Common Table Expression (CTE) that generates a report showing pairs of actors who have appeared in the same film together using the film_actor table, we can self-join the film_actor table. Each row in the film_actor table associates an actor with a film, so a self-join can be used to find pairs of actors who have appeared in the same film.

CTE Query:
sql
Copy code
WITH ActorPairs AS (
    SELECT
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id,
        fa1.film_id
    FROM
        film_actor fa1
    JOIN
        film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE
        fa1.actor_id < fa2.actor_id  -- To avoid duplicate pairs
)
SELECT
    a1.first_name AS actor1_first_name,
    a1.last_name AS actor1_last_name,
    a2.first_name AS actor2_first_name,
    a2.last_name AS actor2_last_name,
    ap.film_id
FROM
    ActorPairs ap
JOIN
    actor a1 ON ap.actor1_id = a1.actor_id
JOIN
    actor a2 ON ap.actor2_id = a2.actor_id
ORDER BY
    ap.film_id, actor1_last_name, actor2_last_name;

    12. CTE for Recursive Search:

 a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager,

 considering the reports_to column.
 To implement a recursive CTE to find all employees in the staff table who report to a specific manager (using the reports_to column), we need to use a recursive query. The staff table has a hierarchical structure, where each employee can report to another employee, and we need to recursively query all employees reporting to a specific manager, including their direct and indirect reports.

Recursive CTE Query:
sql
Copy code
WITH RECURSIVE EmployeeHierarchy AS (
    -- Base case: Select the manager (who has no manager)
    SELECT
        staff_id,
        first_name,
        last_name,
        reports_to
    FROM
        staff
    WHERE
        reports_to = 1  -- Assuming 1 is the manager's staff_id

    UNION ALL

    -- Recursive case: Select employees who report to the staff in the previous level
    SELECT
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM
        staff s
    JOIN
        EmployeeHierarchy eh ON s.reports_to = eh.staff_id
)
SELECT
    staff_id,
    first_name,
    last_name,
    reports_to
FROM
    EmployeeHierarchy
ORDER BY
    staff_id;
Explanation:
WITH RECURSIVE EmployeeHierarchy AS: This defines the recursive CTE called EmployeeHierarchy. The recursive CTE is split into two parts:

Base case: This part selects the employees who directly report to the specified manager (in this case, reports_to = 1 is used to filter for employees reporting to the manager with staff_id = 1).
Recursive case: This part selects employees who report to the employees identified in the previous step (direct or indirect reports).
Base case:

sql
Copy code
SELECT staff_id, first_name, last_name, reports_to
FROM staff
WHERE reports_to = 1
This selects the direct reports of the manager with staff_id = 1. Replace 1 with the manager's staff_id to find employees reporting to that manager.

Recursive case:

sql
Copy code
SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
FROM staff s
JOIN EmployeeHierarchy eh ON s.reports_to = eh.staff_id
This part selects employees who report to anyone in the current EmployeeHierarchy, which allows the query to recursively find indirect reports.

UNION ALL: Combines the base case and recursive case. The base case retrieves the direct reports, and the recursive case keeps fetching indirect reports until no more reports are found.

SELECT staff_id, first_name, last_name, reports_to FROM EmployeeHierarchy: After defining the recursive CTE, this part selects the final list of employees who report to the specified manager.

ORDER BY staff_id: This orders the output by the staff_id to make it easier to read.
