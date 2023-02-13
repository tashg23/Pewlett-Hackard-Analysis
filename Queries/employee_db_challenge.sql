-- Create list of retirement ready employees born between 1952 and 1955
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title, 
	t.from_date, 
	t.to_date 
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Remove duplicate employees
SELECT DISTINCT ON (rt.emp_no) 
	rt.emp_no,
	rt.first_name, 
	rt.last_name, 
	rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no ASC, rt.to_date DESC;

-- Find count of how many retirement ready employees by title 
SELECT COUNT(ut.title),
	ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY count(ut.title) DESC;

-- Find senior employees for mentorship program
SELECT DISTINCT ON (e.emp_no)
	e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date, 
	de.from_date, 
	de.to_date, 
	t.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no ASC;











