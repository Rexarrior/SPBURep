/*Определить фильмы, которые представлены в одном пункте проката и пользуются наибольшим спросом.*/
use sakila; 
select max(rentcount)
from (
	select film_category.category_id, count(rental.rental_id) as rentcount
	from film_category, inventory, rental
	where film_category.film_id = inventory.inventory_id
	and inventory.inventory_id = rental.inventory_id
	and film_category.film_id in (
		select inventory.film_id 
		from inventory
		group by inventory.film_id
		having  count(distinct store_id) = 1
	)
	group by film_category.category_id
	order by rentcount
) T1
