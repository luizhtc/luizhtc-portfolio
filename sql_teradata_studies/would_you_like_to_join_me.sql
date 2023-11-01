/* Outer join simples linkando cliente com sua respectiva compra
   se houver cliente cadastrado com tal ID. */
sel	ord.ord_no,
	ord.purch_amt,
	cust.cust_name,
	cust.city
from orders ord
left join customer cust on ord.customer_id = cust.customer_id
where ord.purch_amt between 500 and 2000;

/* Join para descobrir os managers e a localização de cada departamento,
   retorna depertamento mesmo se não houverem gerentes designados para o departamento */
sel	dep.department_name,
	emp.first_name,
	emp.last_name,
	loc.city
from departments dep
inner join locations loc on dep.location_id = loc.location_id
left join employees_rh emp on emp.employee_id = dep.manager_id;

-- Quantas vezes cada cliente comprou com certo vendedor e qual a soma das compras?
sel	cust.cust_name,
	sale."name" as salesman_name,
	sum(purch_amt),
	count(ord.customer_id) as n_orders
from customer cust
inner join salesman sale on cust.salesman_id = sale.salesman_id
inner join orders ord on ord.customer_id = cust.customer_id
group by cust.cust_name, salesman_name;

-- Quais os empregados que trabalham em qualquer departamento localizado em 'Londres'??
sel	emp.first_name,
	emp.last_name,
	emp.salary
from employees_rh emp
inner join departments dept on emp.department_id = dept.department_id
inner join locations loc on dept.location_id = loc.location_id
where loc.city = 'London';
