# Pewlett-Hackard-Analysis

## Project_objectives: 
To create a SQL database to house all employee information since it was previously stored in various CSV files. As well, to create a list of retirement ready employees to prepare PH for future staffing requirements. 

## Results: 
- We created SQL tables and CSV files with a list of all the retirement ready employees (with their most recent job titles; unique_csv)
- There are 72,458 employees ready for retirement, with 25,916 of them being Senior Engineers and 24,926 being Senior Staff 
- There are only 2 retirement ready managers, so there is less of an urgent need to find new managers 

<img width="163" alt="image" src="https://user-images.githubusercontent.com/113721712/218524258-9e724c98-521c-4793-bd84-22de8b0faeef.png">

- There are 1,549 employees that are eligible for the 'mentorship' program (mentorship_eligibility.csv) 

## Summary: 
- There are 72,458 roles that will need to be filled
- However, there are only 1,549 employees that are eligible for the mentorship program. We could see what titles these employees have to see if they have sufficient knowledge to mentor employees (e.g. an employee may have stayed as a non-senior engineer for their entire career). 

```SQL
-- Check if there are sufficient senior staff/senior engineers for the mentorship program
SELECT count(me.emp_no), 
	me.title
FROM mentorship_eligibility AS me
GROUP BY me.title
ORDER BY (me.count) DESC;
```

<img width="255" alt="mentorship_by_title" src="https://user-images.githubusercontent.com/113721712/218527548-94fda7c6-4fcf-460c-b29f-13680637d828.png">

So while there are 1,549 employees eligible for the mentorship program, only 738 are Senior Staff/Engineers, which may mean there are even less people than expected with the required knowledge to mentor the younger generation. 

As well, the mentorship eligibility table only includes employees who were born in the year 1965. We could possibly expand the eligibility program to look at Senior staff who were born in the year 1964. 

```SQL
-- Find senior employees for mentorship program (1964-1965)
SELECT DISTINCT ON (e.emp_no)
	e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date, 
	de.from_date, 
	de.to_date, 
	t.title
FROM employees as e
LEFT JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1964-01-01' AND '1965-12-31'
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no ASC;
```

This slight change increases our mentorship eligible employees from 1,549 to 19,905. 

Armed with this analysis, PH should have sufficient knowledge to coordinate their future staffing needs. 
