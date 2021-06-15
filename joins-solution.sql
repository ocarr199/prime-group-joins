## Tasks
--1. Get all customers and their addresses

SELECT "customers", "addresses" FROM "customers"
JOIN "addresses" ON "customers".id = "addresses".customer_id;

--2. Get all orders and their line items (orders, quantity and product).
SELECT "orders", "line_items".quantity, "products".description  FROM "orders"
JOIN "line_items" ON "orders".id = "line_items".order_id
JOIN "products" ON "line_items".product_id = "products".id  ; 

--3. Which warehouses have cheetos?

SELECT "warehouse" FROM "warehouse"
JOIN "warehouse_product" ON "warehouse".id = "warehouse_product".warehouse_id
JOIN "products" ON "warehouse_product".product_id = "products".id
WHERE "products".id = 5;

--4. Which warehouses have diet pepsi?
SELECT "warehouse" FROM "warehouse"
JOIN "warehouse_product" ON "warehouse".id = "warehouse_product".warehouse_id
JOIN "products" ON "warehouse_product".product_id = "products".id
WHERE "products".id = 6;


--5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.

SELECT "customers".last_name, COUNT("orders") FROM "orders"
JOIN "addresses" ON "addresses".id = "orders".address_id
JOIN "customers" ON "addresses".customer_id = "customers".id
GROUP BY "customers".last_name ;

--6. How many customers do we have?
SELECT COUNT(*) FROM "customers";

--7. How many products do we carry?
SELECT COUNT(*) FROM "products";

--8. What is the total available on-hand quantity of diet pepsi?
SELECT SUM("warehouse_product".on_hand) FROM "warehouse_product"
JOIN "products" ON "warehouse_product".product_id = "products".id
WHERE "products".id = 6;

## Stretch
--9. How much was the total cost for each order?
SELECT "orders", SUM("unit_price") FROM "products"
JOIN "line_items" ON "products".id = "line_items".product_id
JOIN "orders" ON "line_items".order_id = "orders".id
GROUP BY "orders";

--10. How much has each customer spent in total?
SELECT "customers".last_name, SUM("unit_price") FROM "customers"
JOIN "addresses" ON "customers".id = "addresses".customer_id
JOIN "orders" ON "addresses".id = "orders".address_id
JOIN "line_items" ON "orders".id = "line_items".order_id
JOIN "products" ON "products".id = "line_items".product_id
GROUP BY "customers".last_name;

--11. How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).

