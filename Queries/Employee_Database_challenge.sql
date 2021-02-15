--DELIVERABLE 1:The Number of Retiring Employees by Title

--Retrieve employee data from Employees Table (Steps #1-7 )
SELECT e.emp_no, 
e.first_name, 
e.last_name,
t.title,
t.from_date,
t.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

SELECT * FROM retirement_titles;

-- Use DISTINCT ON with ORDER BY to remove duplicate rows (Steps #8-14)
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY emp_no ASC, to_date DESC;

SELECT * FROM unique_titles;

--Number of employees by their most recent job title who are about to retire.(Steps #15-21)
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

SELECT * FROM retiring_titles;

--DELIVERABLE 2: The Employees Eligible for the Mentorship Program 
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name, 
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31' AND de.to_date = '9999-01-01') 
ORDER BY emp_no;

SELECT * FROM mentorship_eligibilty;

-- ADDITIONAL ANALYSIS for Summary

--Total Employees Retiring
SELECT COUNT (emp_no)
FROM unique_titles;

--The Number of Retiring Employees by Department
SELECT DISTINCT ON (ut.emp_no) ut.emp_no,
ut.first_name, 
ut.last_name,
de.dept_no,
d.dept_name
INTO retirement_dept
FROM unique_titles AS ut
INNER JOIN dept_emp as de
ON (ut.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
ORDER BY emp_no ASC;

SELECT * FROM retirement_dept;

SELECT COUNT(rd.emp_no), rd.dept_name
INTO retiring_dept
FROM retirement_dept as rd
GROUP BY rd.dept_name
ORDER BY COUNT(rd.dept_name) DESC;

SELECT * FROM retiring_dept;

--Employees Eligible for mentorship program by title
SELECT COUNT(me.emp_no), me.title
INTO mentorship_titles
FROM mentorship_eligibilty as me
GROUP BY me.title
ORDER BY COUNT(me.title) DESC;
 
SELECT * FROM mentorship_titles;

--Total Employees Eligible for Mentorship Program
SELECT COUNT (emp_no)
FROM mentorship_eligibilty;

--Expanding criteria for mentorship eligibility program
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name, 
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO expanded_mentorship
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1963-01-01' AND '1965-12-31' AND de.to_date = '9999-01-01') 
ORDER BY emp_no;

SELECT * FROM expanded_mentorship;

--Expanded mentorship eligibility program by title
SELECT COUNT(em.emp_no), em.title
INTO expanded_titles
FROM expanded_mentorship as em
GROUP BY em.title
ORDER BY COUNT(em.title) DESC;
 
SELECT * FROM expanded_titles;
