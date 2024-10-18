create database company;

use company;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    salary DECIMAL(10, 2),
    department_id INT,
    manager_id INT
);

INSERT INTO employees (employee_id, name, age, salary, department_id, manager_id) VALUES
(1, 'Alice', 30, 70000, 1, 3),
(2, 'Bob', 45, 90000, 2, 3),
(3, 'Charlie', 50, 120000, 1, NULL),
(4, 'David', 28, 65000, 3, 5),
(5, 'Eve', 35, 110000, 3, NULL),
(6, 'Frank', 40, 95000, 2, 5);


CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Marketing');



-- ---------- Q U E S TR I O N -------------- --

-- Q1. Retrieve all the columns from the employees table.
select * from employees;

-- Q2. Get all employees who are older than 35.
select * from employees 
where age>35;

-- Q3. Retrieve the names of employees who do not have a manager.
select name from employees 
where manager_id is null;

-- Q4. Find the highest salary in the employees table.
select max(salary) from employees;

-- Q5. List all employees in descending order of their salary.
select * from employees
order by salary desc;

-- Q6. Find the average salary of employees.
select avg(salary) as average_salary from employees;

-- Q7. Select the name and salary of employees, and display the salary as "Employee Salary".
select name,salary as Employees_Salary from employees;

-- Q8. Join the employees table with the departments table to get each employee's name and their department name.
select e.name,d.department_name from employees e
join departments d
on e.department_id=d.department_id;
select * from employees;

-- Q9. Show the total salary for each department.
select d.department_name,sum(e.salary) as total_salary from employees e
join departments d
on e.department_id=d.department_id
group by d.department_name;

-- Q10. List departments where the total salary is greater than 150,000.
select d.department_name,sum(e.salary) from employees e
join departments d
on e.department_id=d.department_id
group by d.department_name
having sum(salary)>150000;

-- Q11. Find employees whose salary is higher than the average salary of all employees.
select * from employees
where salary>(select avg(salary) from employees);

-- Q12. Find pairs of employees who share the same manager.
select * from employees e1
join employees e2
on e1.manager_id=e2.manager_id
where e1.manager_id=e2.manager_id;

-- Q13. Get the count of employees in each department.
select department_name,count(name) as count_of_emp from employees e
join departments d
on e.department_id=d.department_id
group by department_name;

-- Q14. List all employees who earn more than 80,000 and belong to the "IT" department
select * from employees e
join departments d 
on e.department_id=d.department_id
where e.salary>80000 and d.department_name='IT';

-- Q15. Find the employee with the second-highest salary.
select * from employees
order by salary desc
 limit 1 offset 1;
 

 
