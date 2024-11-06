-- (i) A Procedure called PROC_LAB5
DELIMITER //
CREATE PROCEDURE PROC_LAB5()
BEGIN
    SELECT e.employeeNumber, e.firstName, e.lastName, o.city, o.country, SUM(p.amount) AS total_payments
    FROM employees e
    JOIN offices o ON e.officeCode = o.officeCode
    JOIN payments p ON e.employeeNumber = p.customerNumber
    GROUP BY e.employeeNumber, e.firstName, e.lastName, o.city, o.country;
END //
DELIMITER ;

-- (ii) A Function called FUNC_LAB5
DELIMITER //
CREATE FUNCTION FUNC_LAB5(employeeID INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total_salary DECIMAL(10, 2);
    SET total_salary = (SELECT SUM(salary) FROM employees_salary WHERE employeeNumber = employeeID);
    RETURN total_salary;
END //
DELIMITER ;

-- (iii) A View called VIEW_LAB5
CREATE VIEW VIEW_LAB5 AS
SELECT e.employeeNumber AS 'Employee ID', e.firstName AS 'First Name', e.lastName AS 'Last Name', 
       o.city AS 'Office Location (City)', o.country AS 'Office Location (Country)',
       s.employees_salary_amount AS 'Salary', FUNC_LAB5(e.employeeNumber) AS 'Total Salary'
FROM employees e
JOIN offices o ON e.officeCode = o.officeCode
JOIN employees_salary s ON e.employeeNumber = s.employeeNumber;