use hw3;

select *, (select customer_id from orders where orders.id = order_details.order_id) as customer_id from order_details;

select * from order_details where order_id in (select id from orders where shipper_id = 3);

select od.order_id, avg(od.quantity) from (select order_id, quantity from order_details where quantity > 10) as od group by od.order_id;

with temp as (select order_id, quantity from order_details where quantity > 10)
select order_id, avg(quantity) from temp group by order_id;

drop function if exists divide_quantity;
DELIMITER //
create function divide_quantity(first_number float, second_number float) 
returns float 
no sql 
begin 
	declare res float;
	set res = first_number / second_number;
	return res;
end //
delimiter ;

select order_id, quantity, divide_quantity(quantity, 5.0) from order_details;