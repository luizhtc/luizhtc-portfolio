-- Trazendo comandos de agregação para cálculos em uma tabela
select	job_id,
		sum(salary) as salario_total,
		max(salary) as salario_maximo,
		min(salary) as salario_minimo,
		avg(salary) as salario_medio
from employees_rh
where department_id = 90
group by job_id;

-- Exemplo de subselect
select	first_name,
		last_name,
		salary
from employees_rh
where salary > (select max(salary) from employees_rh where last_name = 'Bull');

-- Subselect com retorno de lista
sel	first_name,
	last_name
from employees_rh
where employee_id = any (	sel manager_id
					from employees_rh
					group by manager_id);