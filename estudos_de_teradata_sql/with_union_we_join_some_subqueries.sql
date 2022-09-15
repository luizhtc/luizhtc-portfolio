/* 	Gostaria de agradecer especialmente ao meu mentor Felipe Palmeri que me acompanhou e ensinou no desenvolvimento deste e dos
	outros dois arquivos SQL entitulados "simplicity is the name" e "would you like to join me", respectivamente, durante o
	programa Jump Start na Jump Label Solutions. Os arquivos foram criados como estudos e resoluções das listas de exercício
	passadas durante o Treinamento de SQL, uma das etapas do Jump Start.	*/

-- Usando UNION para determinar atributos específicos a condições nas próprias consultas
SEL customer_id,
	city,
	grade,
	'Classificação alta ' as classificação
FROM customer
WHERE grade >= 300

UNION

SEL	customer_id,
	city,
	grade,
	'Classificação baixa'
FROM customer
WHERE grade < 300 or grade is null;

-- JOIN entre tabela e dicionário de dados, linkando coluna de níveis com cada um dos funcionários em employee_rh
SEL CONCAT(emp.first_name, ' ', emp.last_name) AS full_name,
	emp.salary,
	grd.grade_level
FROM employees_rh emp
INNER JOIN job_grades grd ON emp.salary BETWEEN lowest_sal AND highest_sal;

-- Subselect trazendo informações para uma consulta onde há um atributo fixo
SEL	CONCAT(first_name, ' ', last_name) as employee_name,
	salary,
	department_id,
	job_id
FROM employees_rh
WHERE job_id = (SEL	job_id
				FROM employees_rh
				WHERE employee_id = 169);

-- Uso de BETWEEN...AND com subselect
SEL *
FROM employees_rh
WHERE salary BETWEEN (SEL MIN(salary) FROM employees_rh) AND 2500;

-- Trazer informações sobre os funcionários em employee_rh onde o salário do funcionário é igual ao segundo maior salário
-- Usando WITH e explorando a função analítica ROW_NUMBER()
WITH cte AS (	SEL	ROW_NUMBER() OVER (ORDER BY salary DESC) AS rownumber, -- Common Table Expression
					salary
				FROM employees_rh)
SEL *
FROM employees_rh
WHERE salary = (SEL salary
				FROM cte
				WHERE rownumber = 2);

-- O mesmo exemplo acima, porém resolvido com subqueries
SEL *
FROM employees_rh
WHERE salary = (	SEL MAX(salary)
			FROM employees_rh
			WHERE salary <> (	SEL MAX(salary)
						FROM employees_rh));

-- Listar quando o salário do funcionário está ABAIXO ou ACIMA da média de salários de seu departamento
SEL 	emp.employee_id,
	CONCAT(emp.first_name, ' ', emp.last_name) AS employee_name,
	emp.salary,
	dept.department_name,
	CASE	WHEN dept_avg_salary <= salary THEN 'HIGH'
		WHEN dept_avg_salary > salary THEN 'LOW'
	END AS dept_salary_status
FROM employees_rh emp
INNER JOIN departments dept ON emp.department_id = dept.department_id
INNER JOIN (SEL	department_id,
			AVG(salary) AS dept_avg_salary
			FROM employees_rh
			GROUP BY department_id) temp ON emp.department_id = temp.department_id;

-- Trazer informações dos funcionários que tem salário maior que 50% da soma dos salários em seu departamento.
-- Utilizando subqueries relacionadas
SEL CONCAT(emp.first_name, ' ', emp.last_name) AS employee_name,
	emp.salary,
	dept.department_name
FROM employees_rh emp
INNER JOIN departments dept ON emp.department_id = dept.department_id
WHERE emp.salary > ((	SEL SUM(salary) 
				FROM employees_rh emp_in 
				WHERE emp_in.department_id = emp.department_id) * 0.5);

-- Trazendo informações dos funcionários que são managers de 4 ou mais funcionários e seus departamentos
-- Utilizando subselects com join
SEL 	CONCAT(emp.first_name, ' ', emp.last_name) AS manager_name,
	dept.department_name
FROM employees_rh emp
INNER JOIN departments dept ON emp.department_id = dept.department_id
WHERE emp.employee_id IN (	SEL manager_id
					FROM employees_rh
					GROUP BY manager_id
					HAVING COUNT(manager_id) >= 4);

-- Trazer informações dos funcionários que tem salário menor que seu gerente, porém tem salários maiores que todos os outros gerentes
-- Utilizando JOIN e subqueries relacionadas
SEL *
FROM employees_rh emp
INNER JOIN (SEL employee_id, salary AS mng_salary
		FROM employees_rh) temp ON emp.manager_id = temp.employee_id
WHERE emp.salary < temp.mng_salary
AND emp.salary >=  (	SEL MAX(temp2_in.salary) AS temp_salary
				FROM employees_rh temp_in
				INNER JOIN employees_rh temp2_in ON temp_in.employee_id = temp2_in.manager_id
				WHERE emp.manager_id <> temp2_in.employee_id);