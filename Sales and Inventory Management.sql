REM   Script: Sales and Inventory management
REM   Homework

create table bricks ( 
  brick_id integer, 
  colour   varchar2(10), 
  shape    varchar2(10), 
  weight   integer 
);

insert into bricks values ( 1, 'blue', 'cube', 1 );

insert into bricks values ( 2, 'blue', 'pyramid', 2 );

insert into bricks values ( 3, 'red', 'cube', 1 );

insert into bricks values ( 4, 'red', 'cube', 2 );

insert into bricks values ( 5, 'red', 'pyramid', 3 );

insert into bricks values ( 6, 'green', 'pyramid', 1 );

commit;

CREATE TABLE products ( 
    product_id NUMBER PRIMARY KEY, 
    product_name VARCHAR2(100), 
    category VARCHAR2(50), 
    unit_price NUMBER 
);

CREATE TABLE customers ( 
    customer_id NUMBER PRIMARY KEY, 
    customer_name VARCHAR2(100), 
    city VARCHAR2(50), 
    membership_level VARCHAR2(20) 
);

CREATE TABLE sales ( 
    sale_id NUMBER PRIMARY KEY, 
    product_id NUMBER, 
    customer_id NUMBER, 
    sale_date DATE, 
    quantity_sold NUMBER, 
    total_amount NUMBER, 
    FOREIGN KEY (product_id) REFERENCES products(product_id), 
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
);

INSERT INTO products VALUES (1, 'Laptop', 'Electronics', 1000);

INSERT INTO products VALUES (2, 'T-Shirt', 'Clothing', 20);

INSERT INTO products VALUES (3, 'mouse', 'Electronics', 20);

INSERT INTO products VALUES (4, 'keyboard', 'Electronics', 20);

INSERT INTO products VALUES (5, 'pufferjacket', 'Clothing', 20);

INSERT INTO products VALUES (3, 'mouse', 'Electronics', 30);

INSERT INTO products VALUES (4, 'keyboard', 'Electronics', 40);

INSERT INTO products VALUES (5, 'pufferjacket', 'Clothing', 350);

INSERT INTO customers VALUES (101, 'John Doe', 'New York', 'Gold');

INSERT INTO customers VALUES (102, 'Jane Smith', 'Los Angeles', 'Silver');

INSERT INTO customers VALUES (103, 'Vaibhav Shete', 'Las Vegas', 'Platinum');

INSERT INTO customers VALUES (104, 'Pintya Yeole', 'OakLand', 'Silver');

INSERT INTO customers VALUES (105, 'Tanmay Singh', ' SF', 'Gold');

INSERT INTO sales VALUES (1001, 1, 101, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 2, 2000);

INSERT INTO sales VALUES (1002, 2, 102, TO_DATE('2023-01-02', 'YYYY-MM-DD'), 5, 100);

INSERT INTO sales VALUES (1003, 3, 103, TO_DATE('2023-01-03', 'YYYY-MM-DD'), 3, 200);

INSERT INTO sales VALUES (1004, 4, 104, TO_DATE('2023-01-04', 'YYYY-MM-DD'), 6, 300);

INSERT INTO sales VALUES (1005, 5, 105, TO_DATE('2023-01-05', 'YYYY-MM-DD'), 1, 250);

SELECT p.category, AVG(s.total_amount) OVER (PARTITION BY p.category) AS avg_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id;

SELECT p.category, AVG(s.total_amount) OVER (PARTITION BY p.category) AS avg_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id;

SELECT c.customer_name, RANK() OVER (ORDER BY SUM(s.total_amount) DESC) AS customer_rank 
FROM sales s 
JOIN customers c ON s.customer_id = c.customer_id 
GROUP BY c.customer_name;

SELECT c.customer_name, s.sale_date, s.total_amount,  
       PERCENT_RANK() OVER (PARTITION BY c.customer_name ORDER BY s.total_amount) AS cumulative_distribution 
FROM sales s 
JOIN customers c ON s.customer_id = c.customer_id;

SELECT s.sale_id, s.sale_date, s.total_amount, 
       LAG(s.total_amount) OVER (ORDER BY s.sale_date) AS prev_sale_amount, 
       LEAD(s.total_amount) OVER (ORDER BY s.sale_date) AS next_sale_amount 
FROM sales s;

SELECT s.sale_id, s.sale_date, s.total_amount, 
       100 * (s.total_amount - LAG(s.total_amount) OVER (ORDER BY s.sale_date)) / LAG(s.total_amount) OVER (ORDER BY s.sale_date) AS percent_change 
FROM sales s;

SELECT p.product_name, s.sale_date, s.total_amount, 
       AVG(s.total_amount) OVER (PARTITION BY p.product_name ORDER BY s.sale_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg 
FROM sales s 
JOIN products p ON s.product_id = p.product_id;

- Percent change in sales amount compared to the previous sale 


SELECT s.sale_id, s.sale_date, s.total_amount, 
       100 * (s.total_amount - LAG(s.total_amount) OVER (ORDER BY s.sale_date)) / LAG(s.total_amount) OVER (ORDER BY s.sale_date) AS percent_change 
FROM sales s;

- Percent change in sales amount compared to the previous sale 


SELECT s.sale_id, s.sale_date, s.total_amount, 
       100 * (s.total_amount - LAG(s.total_amount) OVER (ORDER BY s.sale_date)) / LAG(s.total_amount) OVER (ORDER BY s.sale_date) AS percent_change 
FROM sales s;

- Percent change in sales amount compared to the previous sale 


SELECT s.sale_id, s.sale_date, s.total_amount, 
       100 * (s.total_amount - LAG(s.total_amount) OVER (ORDER BY s.sale_date)) / LAG(s.total_amount) OVER (ORDER BY s.sale_date) AS percent_change 
FROM sales s;

SELECT s.sale_id, s.sale_date, s.total_amount, 
       LAG(s.total_amount) OVER (ORDER BY s.sale_date) AS prev_sale_amount, 
       LEAD(s.total_amount) OVER (ORDER BY s.sale_date) AS next_sale_amount 
FROM sales s;

SELECT s.sale_id, s.sale_date, s.total_amount, 
       LAG(s.total_amount) OVER (ORDER BY s.sale_date) AS prev_sale_amount, 
       LEAD(s.total_amount) OVER (ORDER BY s.sale_date) AS next_sale_amount 
FROM sales s;

SELECT c.customer_name, s.sale_date, s.total_amount,  
       PERCENT_RANK() OVER (PARTITION BY c.customer_name ORDER BY s.total_amount) AS cumulative_distribution 
FROM sales s 
JOIN customers c ON s.customer_id = c.customer_id;

SELECT c.customer_name, RANK() OVER (ORDER BY SUM(s.total_amount) DESC) AS customer_rank 
FROM sales s 
JOIN customers c ON s.customer_id = c.customer_id 
GROUP BY c.customer_name;

 Average total amount of sales by product category 


SELECT p.category, AVG(s.total_amount) OVER (PARTITION BY p.category) AS avg_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id;

SELECT p.category, c.city, c.membership_level, SUM(s.total_amount) AS total_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id 
JOIN customers c ON s.customer_id = c.customer_id 
GROUP BY CUBE (p.category, c.city, c.membership_level);

SELECT p.category, c.city, c.membership_level, AVG(s.total_amount) AS avg_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id 
JOIN customers c ON s.customer_id = c.customer_id 
GROUP BY ROLLUP (p.category, c.city, c.membership_level);

CREATE TABLE products ( 
    product_id NUMBER PRIMARY KEY, 
    product_name VARCHAR2(100), 
    category VARCHAR2(50), 
    unit_price NUMBER 
);

CREATE TABLE customers ( 
    customer_id NUMBER PRIMARY KEY, 
    customer_name VARCHAR2(100), 
    city VARCHAR2(50), 
    membership_level VARCHAR2(20) 
);

CREATE TABLE sales ( 
    sale_id NUMBER PRIMARY KEY, 
    product_id NUMBER, 
    customer_id NUMBER, 
    sale_date DATE, 
    quantity_sold NUMBER, 
    total_amount NUMBER, 
    FOREIGN KEY (product_id) REFERENCES products(product_id), 
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
);

INSERT INTO products VALUES (1, 'Laptop', 'Electronics', 1000);

INSERT INTO products VALUES (2, 'T-Shirt', 'Clothing', 20);

INSERT INTO products VALUES (3, 'mouse', 'Electronics', 30);

INSERT INTO products VALUES (4, 'keyboard', 'Electronics', 40);

INSERT INTO products VALUES (5, 'pufferjacket', 'Clothing', 350);

INSERT INTO customers VALUES (101, 'John Doe', 'New York', 'Gold');

INSERT INTO customers VALUES (102, 'Jane Smith', 'Los Angeles', 'Silver');

INSERT INTO customers VALUES (103, 'Vaibhav Shete', 'Las Vegas', 'Platinum');

INSERT INTO customers VALUES (104, 'Pintya Yeole', 'OakLand', 'Silver');

INSERT INTO customers VALUES (105, 'Tanmay Singh', ' SF', 'Gold');

INSERT INTO sales VALUES (1001, 1, 101, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 2, 2000);

INSERT INTO sales VALUES (1002, 2, 102, TO_DATE('2023-01-02', 'YYYY-MM-DD'), 5, 100);

INSERT INTO sales VALUES (1003, 3, 103, TO_DATE('2023-01-03', 'YYYY-MM-DD'), 3, 200);

INSERT INTO sales VALUES (1004, 4, 104, TO_DATE('2023-01-04', 'YYYY-MM-DD'), 6, 300);

INSERT INTO sales VALUES (1005, 5, 105, TO_DATE('2023-01-05', 'YYYY-MM-DD'), 1, 250);

SELECT p.category, AVG(s.total_amount) OVER (PARTITION BY p.category) AS avg_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id;

SELECT c.customer_name, RANK() OVER (ORDER BY SUM(s.total_amount) DESC) AS customer_rank 
FROM sales s 
JOIN customers c ON s.customer_id = c.customer_id 
GROUP BY c.customer_name;

SELECT c.customer_name, s.sale_date, s.total_amount,  
       PERCENT_RANK() OVER (PARTITION BY c.customer_name ORDER BY s.total_amount) AS cumulative_distribution 
FROM sales s 
JOIN customers c ON s.customer_id = c.customer_id;

SELECT s.sale_id, s.sale_date, s.total_amount, 
       LAG(s.total_amount) OVER (ORDER BY s.sale_date) AS prev_sale_amount, 
       LEAD(s.total_amount) OVER (ORDER BY s.sale_date) AS next_sale_amount 
FROM sales s;

SELECT s.sale_id, s.sale_date, s.total_amount, 
       100 * (s.total_amount - LAG(s.total_amount) OVER (ORDER BY s.sale_date)) / LAG(s.total_amount) OVER (ORDER BY s.sale_date) AS percent_change 
FROM sales s;

SELECT p.product_name, s.sale_date, s.total_amount, 
       AVG(s.total_amount) OVER (PARTITION BY p.product_name ORDER BY s.sale_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg 
FROM sales s 
JOIN products p ON s.product_id = p.product_id;

SELECT p.category, c.city, c.membership_level, SUM(s.total_amount) AS total_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id 
JOIN customers c ON s.customer_id = c.customer_id 
GROUP BY CUBE (p.category, c.city, c.membership_level);

SELECT p.category, c.city, c.membership_level, AVG(s.total_amount) AS avg_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id 
JOIN customers c ON s.customer_id = c.customer_id 
GROUP BY ROLLUP (p.category, c.city, c.membership_level);

SELECT p.category, c.membership_level, SUM(s.total_amount) AS total_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id 
JOIN customers c ON s.customer_id = c.customer_id 
GROUP BY CUBE (p.category, c.membership_level);

SELECT p.category, c.city, c.membership_level, AVG(s.total_amount) AS avg_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id 
JOIN customers c ON s.customer_id = c.customer_id 
GROUP BY ROLLUP (p.category, c.city, c.membership_level);

SELECT p.category, c.city, SUM(s.total_amount) AS total_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id 
JOIN customers c ON s.customer_id = c.customer_id 
GROUP BY CUBE (p.category, c.city);

SELECT p.category, AVG(s.total_amount) AS avg_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id 
GROUP BY ROLLUP (p.category);

SELECT p.category, c.city, c.membership_level, SUM(s.total_amount) AS total_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id 
JOIN customers c ON s.customer_id = c.customer_id 
GROUP BY CUBE (p.category, c.city, c.membership_level);

SELECT p.category, c.city, c.membership_level, AVG(s.total_amount) AS avg_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id 
JOIN customers c ON s.customer_id = c.customer_id 
GROUP BY ROLLUP (p.category, c.city, c.membership_level);

SELECT p.category, c.city, SUM(s.total_amount) AS total_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id 
JOIN customers c ON s.customer_id = c.customer_id 
GROUP BY CUBE (p.category, c.city);

SELECT p.category, AVG(s.total_amount) AS avg_sales_amount 
FROM sales s 
JOIN products p ON s.product_id = p.product_id 
GROUP BY ROLLUP (p.category);

