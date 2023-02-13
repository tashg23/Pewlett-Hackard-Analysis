-- Retirement eligibility 
SELECT first_name, last_name
INTO retirement_info
FROM employees 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31'); 

-- Check table 
SELECT * FROM retirement_info;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no, 
	retirement_info.first_name, 
	retirement_info.last_name, 
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no; 

SELECT ri.emp_no, 
	ri.first_name, 
	ri.last_name, 
	de.to_date
INTO current_emp 
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

SELECT * FROM current_emp;

-- Employee count by department number 
SELECT count(ce.emp_no),
	de.dept_no
INTO current_dept
FROM current_emp AS ce
LEFT JOIN dept_emp AS de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM current_dept;

-- Employee information 
SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.gender, 
	s.salary,
	de.to_date 
INTO emp_info
FROM employees AS e 
INNER JOIN salaries AS s 
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');

-- Retiring managers
SELECT dm.dept_no, 
	d.dept_name, 
	dm.emp_no, 
	ce.last_name, 
	ce.first_name, 
	dm.from_date, 
	dm.to_date 
INTO manager_info
FROM dept_manager AS dm
INNER JOIN departments AS d
ON (dm.dept_no = d.dept_no)
INNER JOIN current_emp AS ce
ON (dm.emp_no = ce.emp_no);

-- Department retirees
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- Table for sales team 
SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	d.dept_name 
INTO retirement_sales_team
FROM employees AS e
INNER JOIN dept_emp 
ON (e.emp_no = dept_emp.emp_no)
INNER JOIN departments AS d 
ON (dept_emp.dept_no = d.dept_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (dept_emp.to_date = '9999-01-01')
	 AND (d.dept_name = 'Sales');
	
SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	d.dept_name 
INTO retirement_sales_development
FROM employees AS e
INNER JOIN dept_emp 
ON (e.emp_no = dept_emp.emp_no)
INNER JOIN departments AS d 
ON (dept_emp.dept_no = d.dept_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (dept_emp.to_date = '9999-01-01')
	 AND d.dept_name IN ('Sales', 'Development');











