-- Data base and prompts available for free on https://www.udemy.com/course/sql-basics-for-beginners-free-starter-guide/
--
-- Customers Who Never Placed an Order
--
select users.user_id, users.user_name
from users left join orders 
on users.user_id = orders.user_id
where orders.order_id is null;

-- Users with Gmail or Outlook Emails

select user_id, email from users
where email like '%@gmail.com' or email like '%outlook.com'   


-- Detect Incomplete User Profiles

select user_id, user_name from users
where NOT email AND NOT phone AND city
or email AND NOT phone AND NOT city
or NOT email AND phone AND NOT city
or NOT email AND NOT phone AND NOT city
