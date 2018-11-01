use sakila;
select customer.first_name, address.address  from customer join address on customer.address_id = address.address_id