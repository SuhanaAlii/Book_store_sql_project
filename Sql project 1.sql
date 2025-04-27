
use book_store;
--altering the datatype of orders to date
ALTER TABLE ORDERS
MODIFY COLUMN Order_Date DATE;
--retrieving all books from the "fiction" genre.
select *
from books 
where genre='fiction';
--Finding books published after 1950 and ordered them by ascending order
select*
from books
where published_year>1950
order by published_year asc;
--listing all the customers from canada
select *
from customers
where country='canada';
--listing all orders placed during november and ordered them ascending order
select* from orders;
select *
from orders
where order_date BETWEEN '2023-11-01' and '2023-11-30'
order by order_date asc ;
-- retrieve the tota stocks of books available
select sum(stock) as Total_stocks
from books;
--find the details of most expensive book
select * 
from books 
order by price desc
limit 1;
--show all customers who ordered more than one book
select*
from orders
where quantity > 1
order by quantity desc;
--retrieve all orders which exceeds $20
select*
from orders
where price>20;
-- list all the genre in the books table
select distinct genre 
from books ;
--find the book with lowest stock usiing sub-query
select*
from books
where stock=(select min(stock) from books)
limit 1;
-- calculate total revenue generated from all orders
select round(sum(total_amount),2) as Total_revenue
from orders;
-- calculate the total number for book sold by each genre
select b.genre,sum(o.quantity) as Total_quantity
from orders as o
join books as b
on b.book_id=o.book_id
group by b.genre;
--finding average price of books in the 'Fantasy' genre
select ROUND(avg(price), 2) as Average
from books
where genre='Fantasy';
--list the customers who have placed atleast two orders
select o.customer_id,c.name,count(o.order_id) as order_count
from orders as o
join customers as c 
on o.customer_id=c.customer_id
group by o.customer_id,c.name
having count(o.order_id)>=2; 
--find the most frequently ordered book
select b.title,o.book_id,count(o.order_id) as Order_count
from orders as o
join books as b
on b.book_id=o.book_id
group by o.book_id,b.title
order by Order_count desc 
limit 1;
--show the top 3 most expensive book of the 'Fantasy' categry
select *
from books
where genre='Fantasy'
order by price desc
limit 3;
--retrieve the total quantity of books sold by each author
select b.author,sum(o.quantity) as total_quantity
from orders as o
join books as b 
on o.book_id=b.book_id
group by author;
--list the cities where customers who spent over $30 are located
select distinct(c.city), total_amount
from orders as o
join customers as c
on c.customer_id = o.customer_id
where o.total_amount>30;
-- find the customer who spent the most on orders
select c.customer_id,c.name,sum(o.total_amount) as total_amount
from customers as c
join orders as o
on c.customer_id = o.customer_id
group by c.customer_id,c.name
order by total_amount desc
limit 1;
-- calculate the stocks remaining after fulfilling all orders
select b.book_id,b.title,b.stock,COALESCE(sum(o.quantity),0) As order_quantity,
b.stock-COALESCE(sum(o.quantity),0) as Remaining_quantity
from books as b
left join orders as o
on b.book_id=o.book_id
group by b.book_id,b.title,b.stock
order by b.book_id;
--show low stock alert
SELECT book_id, title, stock 
FROM books as b
WHERE stock - COALESCE((SELECT SUM(quantity) FROM orders as o WHERE o.book_id = b.book_id), 0) < 5
order by stock;


















