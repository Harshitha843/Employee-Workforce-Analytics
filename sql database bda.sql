CREATE DATABASE EmployeeWorkforceDB;
USE EmployeeWorkforceDB;
CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50) NOT NULL,
    Location VARCHAR(50)
);
INSERT INTO Department
(Department_ID, Department_Name, Location)
VALUES
(101, 'Information Technology', 'Chennai'),
(102, 'Human Resources', 'Bangalore'),
(103, 'Finance', 'Chennai'),
(104, 'Marketing', 'Mumbai'),
(105, 'Sales', 'Bangalore'),
(106, 'Operations', 'Hyderabad'),
(107, 'Customer Support', 'Pune'),
(108, 'Research and Development', 'Chennai'),
(109, 'Administration', 'Delhi'),
(110, 'Data Analytics', 'Bangalore');
select * from Department;
/* employee table*/
CREATE TABLE EmployeeTab (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(100),
    Gender VARCHAR(10),
    Date_of_Birth DATE,
    Hire_Date DATE,
    Job_Title VARCHAR(60),
    Department_ID INT,
    Employment_Status VARCHAR(20),
    Education_Level VARCHAR(30),
    Experience_Years DECIMAL(4,1),
    FOREIGN KEY (Department_ID)
        REFERENCES Department(Department_ID)
);
WITH RECURSIVE EmployeeNumbers AS
(
    SELECT 1001 AS Employee_ID

    UNION ALL

    SELECT Employee_ID + 1
    FROM EmployeeNumbers
    WHERE Employee_ID < 2200
)
SELECT *
FROM EmployeeNumbers;
SET SESSION cte_max_recursion_depth = 2000;
INSERT INTO EmployeeTab
(
    Employee_ID,
    Employee_Name,
    Gender,
    Date_of_Birth,
    Hire_Date,
    Job_Title,
    Department_ID,
    Employment_Status,
    Education_Level,
    Experience_Years
)
WITH RECURSIVE EmployeeNumbers AS
(
    SELECT 1001 AS Employee_ID

    UNION ALL

    SELECT Employee_ID + 1
    FROM EmployeeNumbers
    WHERE Employee_ID < 2200
)
SELECT
    Employee_ID,

    CONCAT(
        CASE MOD(Employee_ID, 20)
            WHEN 0 THEN 'Arun'
            WHEN 1 THEN 'Priya'
            WHEN 2 THEN 'Rahul'
            WHEN 3 THEN 'Divya'
            WHEN 4 THEN 'Karthik'
            WHEN 5 THEN 'Meena'
            WHEN 6 THEN 'Vijay'
            WHEN 7 THEN 'Anitha'
            WHEN 8 THEN 'Suresh'
            WHEN 9 THEN 'Keerthana'
            WHEN 10 THEN 'Ravi'
            WHEN 11 THEN 'Nandhini'
            WHEN 12 THEN 'Vishal'
            WHEN 13 THEN 'Swetha'
            WHEN 14 THEN 'Ajay'
            WHEN 15 THEN 'Harini'
            WHEN 16 THEN 'Manoj'
            WHEN 17 THEN 'Pooja'
            WHEN 18 THEN 'Santhosh'
            ELSE 'Lakshmi'
        END,
        ' ',
        CASE MOD(Employee_ID, 15)
            WHEN 0 THEN 'Kumar'
            WHEN 1 THEN 'Sharma'
            WHEN 2 THEN 'Raj'
            WHEN 3 THEN 'Reddy'
            WHEN 4 THEN 'Patel'
            WHEN 5 THEN 'Iyer'
            WHEN 6 THEN 'Nair'
            WHEN 7 THEN 'Das'
            WHEN 8 THEN 'Singh'
            WHEN 9 THEN 'Verma'
            WHEN 10 THEN 'Menon'
            WHEN 11 THEN 'Bose'
            WHEN 12 THEN 'Gupta'
            WHEN 13 THEN 'Rao'
            ELSE 'Pillai'
        END
    ),

    CASE
        WHEN MOD(Employee_ID, 2) = 0 THEN 'Female'
        ELSE 'Male'
    END,

    DATE_ADD(
        '1985-01-01',
        INTERVAL MOD(Employee_ID * 37, 6500) DAY
    ),

    DATE_ADD(
        '2015-01-01',
        INTERVAL MOD(Employee_ID * 29, 4200) DAY
    ),

    CASE MOD(Employee_ID, 15)
        WHEN 0 THEN 'Software Engineer'
        WHEN 1 THEN 'Senior Software Engineer'
        WHEN 2 THEN 'HR Executive'
        WHEN 3 THEN 'Financial Analyst'
        WHEN 4 THEN 'UI UX Designer'
        WHEN 5 THEN 'Sales Executive'
        WHEN 6 THEN 'Marketing Executive'
        WHEN 7 THEN 'Data Analyst'
        WHEN 8 THEN 'Project Manager'
        WHEN 9 THEN 'Business Analyst'
        WHEN 10 THEN 'Operations Executive'
        WHEN 11 THEN 'Customer Support Executive'
        WHEN 12 THEN 'Research Associate'
        WHEN 13 THEN 'Accountant'
        ELSE 'System Administrator'
    END,

    101 + MOD(Employee_ID, 10),

    CASE
        WHEN MOD(Employee_ID, 20) = 0 THEN 'On Leave'
        WHEN MOD(Employee_ID, 37) = 0 THEN 'Resigned'
        ELSE 'Active'
    END,

    CASE MOD(Employee_ID, 4)
        WHEN 0 THEN 'Bachelor Degree'
        WHEN 1 THEN 'Master Degree'
        WHEN 2 THEN 'Bachelor Degree'
        ELSE 'Master Degree'
    END,

    ROUND(
        1 + MOD(Employee_ID * 13, 120) / 10,
        1
    )

FROM EmployeeNumbers;
SELECT COUNT(*) AS Total_Employees
FROM EmployeeTab;
SELECT * FROM EmployeeTab
LIMIT 100;
SELECT COUNT(*) AS Total_Employees
FROM EmployeeTab;
select * from EmployeeNumbers;
/*salary table*/
CREATE TABLE Salary (
    Salary_ID INT PRIMARY KEY,
    Employee_ID INT,
    Monthly_Salary DECIMAL(10,2),
    Bonus DECIMAL(10,2),
    Salary_Year INT,
    FOREIGN KEY (Employee_ID)
        REFERENCES EmployeeTab(Employee_ID)
);
INSERT INTO Salary
(
    Salary_ID,
    Employee_ID,
    Monthly_Salary,
    Bonus,
    Salary_Year
)
SELECT
    Employee_ID - 1000,
    Employee_ID,

    30000 + MOD(Employee_ID * 157, 70001),

    5000 + MOD(Employee_ID * 83, 25001),

    2026

FROM EmployeeTab;
SELECT COUNT(*) AS Total_Salary_Records
FROM Salary;
select * from Salary;
/* performance table*/
CREATE TABLE Performance (
    Performance_ID INT PRIMARY KEY,
    Employee_ID INT,
    Review_Date DATE,
    Performance_Score DECIMAL(5,2),
    Productivity_Score DECIMAL(5,2),
    Quality_Score DECIMAL(5,2),
    Teamwork_Score DECIMAL(5,2),
    Overall_Rating VARCHAR(30),

    FOREIGN KEY (Employee_ID)
        REFERENCES EmployeeTab(Employee_ID)
);
INSERT INTO Performance
(
    Performance_ID,
    Employee_ID,
    Review_Date,
    Performance_Score,
    Productivity_Score,
    Quality_Score,
    Teamwork_Score,
    Overall_Rating
)
SELECT
    Employee_ID - 1000,

    Employee_ID,

    '2026-09-15',

    60 + MOD(Employee_ID * 17, 41),

    60 + MOD(Employee_ID * 23, 41),

    60 + MOD(Employee_ID * 31, 41),

    60 + MOD(Employee_ID * 41, 41),

    CASE
        WHEN (60 + MOD(Employee_ID * 17, 41)) >= 90
            THEN 'Excellent'

        WHEN (60 + MOD(Employee_ID * 17, 41)) >= 80
            THEN 'Very Good'

        WHEN (60 + MOD(Employee_ID * 17, 41)) >= 70
            THEN 'Good'

        ELSE 'Needs Improvement'
    END

FROM EmployeeTab;
SELECT COUNT(*) AS Total_Performance_Records
FROM Performance;
select * from Performance;

/* attendance tablr*/
CREATE TABLE Attendance (
    Attendance_ID INT PRIMARY KEY,
    Employee_ID INT,
    Attendance_Date DATE,
    Status VARCHAR(20),
    Work_Hours DECIMAL(4,2),

    FOREIGN KEY (Employee_ID)
        REFERENCES EmployeeTab(Employee_ID)
);
SET SESSION cte_max_recursion_depth = 2000;
INSERT INTO Attendance
(
    Attendance_ID,
    Employee_ID,
    Attendance_Date,
    Status,
    Work_Hours
)
WITH RECURSIVE EmployeeNumbers AS
(
    SELECT 1001 AS Employee_ID

    UNION ALL

    SELECT Employee_ID + 1
    FROM EmployeeNumbers
    WHERE Employee_ID < 2200
),
DateNumbers AS
(
    SELECT 0 AS Day_Number

    UNION ALL

    SELECT Day_Number + 1
    FROM DateNumbers
    WHERE Day_Number < 29
)
SELECT
    ((Employee_ID - 1001) * 30) + Day_Number + 1,

    Employee_ID,

    DATE_ADD(
        '2026-08-01',
        INTERVAL Day_Number DAY
    ),

    CASE
        WHEN MOD(Employee_ID + Day_Number, 17) = 0
            THEN 'Leave'

        WHEN MOD(Employee_ID + Day_Number, 23) = 0
            THEN 'Absent'

        ELSE 'Present'
    END,

    CASE
        WHEN MOD(Employee_ID + Day_Number, 17) = 0
            THEN 0

        WHEN MOD(Employee_ID + Day_Number, 23) = 0
            THEN 0

        ELSE ROUND(
            7 + MOD(Employee_ID + Day_Number, 21) / 10,
            1
        )
    END

FROM EmployeeNumbers
CROSS JOIN DateNumbers;
SELECT COUNT(*) AS Total_Attendance_Records
FROM Attendance;
select * from Attendance;


/*Queries toatal employees*/
SELECT COUNT(*) AS Total_Employees
FROM EmployeeTab;
/*Employees by department*/

SELECT
    d.Department_Name,
    COUNT(e.Employee_ID) AS Total_Employees
FROM EmployeeTab e
JOIN Department d
    ON e.Department_ID = d.Department_ID
GROUP BY d.Department_Name
ORDER BY Total_Employees DESC;

/*Average performance  */
SELECT
    ROUND(AVG(Performance_Score), 2) AS Average_Performance
FROM Performance;

/*Department-wise Performance*/
SELECT
    d.Department_Name,
    COUNT(e.Employee_ID) AS Total_Employees,
    ROUND(AVG(p.Performance_Score), 2) AS Average_Performance
FROM EmployeeTab e
JOIN Department d
    ON e.Department_ID = d.Department_ID
JOIN Performance p
    ON e.Employee_ID = p.Employee_ID
GROUP BY d.Department_Name
ORDER BY Average_Performance DESC;

/*Attendance Percentage*/
SELECT
    ROUND(
        SUM(CASE WHEN Status = 'Present' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Attendance_Percentage
FROM Attendance;

/*Average Salary*/
SELECT
    ROUND(AVG(Monthly_Salary), 2) AS Average_Monthly_Salary
FROM Salary;

SELECT
    d.Department_Name,
    ROUND(AVG(s.Monthly_Salary), 2) AS Average_Salary
FROM EmployeeTab e
JOIN Department d
    ON e.Department_ID = d.Department_ID
JOIN Salary s
    ON e.Employee_ID = s.Employee_ID
GROUP BY d.Department_Name
ORDER BY Average_Salary DESC;

/*Top-Performing Employees*/
SELECT
    e.Employee_ID,
    e.Employee_Name,
    d.Department_Name,
    p.Performance_Score,
    p.Overall_Rating
FROM EmployeeTab e
JOIN Department d
    ON e.Department_ID = d.Department_ID
JOIN Performance p
    ON e.Employee_ID = p.Employee_ID
ORDER BY p.Performance_Score DESC
LIMIT 10;

/*Salary vs Performance*/
SELECT
    e.Employee_ID,
    e.Employee_Name,
    d.Department_Name,
    s.Monthly_Salary,
    p.Performance_Score,
    p.Overall_Rating
FROM EmployeeTab e
JOIN Department d
    ON e.Department_ID = d.Department_ID
JOIN Salary s
    ON e.Employee_ID = s.Employee_ID
JOIN Performance p
    ON e.Employee_ID = p.Employee_ID
ORDER BY p.Performance_Score DESC;


SELECT
    e.Employee_ID,
    e.Employee_Name,
    d.Department_Name,

    s.Monthly_Salary,

    p.Performance_Score,

    COUNT(a.Attendance_ID) AS Total_Days,

    SUM(
        CASE
            WHEN a.Status = 'Present' THEN 1
            ELSE 0
        END
    ) AS Present_Days,

    ROUND(
        SUM(
            CASE
                WHEN a.Status = 'Present' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(a.Attendance_ID),
        2
    ) AS Attendance_Percentage

FROM EmployeeTab e

JOIN Department d
    ON e.Department_ID = d.Department_ID

JOIN Salary s
    ON e.Employee_ID = s.Employee_ID

JOIN Performance p
    ON e.Employee_ID = p.Employee_ID

JOIN Attendance a
    ON e.Employee_ID = a.Employee_ID

GROUP BY
    e.Employee_ID,
    e.Employee_Name,
    d.Department_Name,
    s.Monthly_Salary,
    p.Performance_Score

ORDER BY p.Performance_Score DESC;

CREATE VIEW Employee_Workforce_Analytics AS

SELECT
    e.Employee_ID,
    e.Employee_Name,
    e.Gender,
    e.Job_Title,
    e.Education_Level,
    e.Experience_Years,

    d.Department_Name,
    d.Location,

    e.Employment_Status,

    s.Monthly_Salary,
    s.Bonus,
    s.Salary_Year,

    p.Review_Date,
    p.Performance_Score,
    p.Productivity_Score,
    p.Quality_Score,
    p.Teamwork_Score,
    p.Overall_Rating,

    COUNT(a.Attendance_ID) AS Total_Attendance_Days,

    SUM(
        CASE
            WHEN a.Status = 'Present' THEN 1
            ELSE 0
        END
    ) AS Present_Days,

    SUM(
        CASE
            WHEN a.Status = 'Absent' THEN 1
            ELSE 0
        END
    ) AS Absent_Days,

    SUM(
        CASE
            WHEN a.Status = 'Leave' THEN 1
            ELSE 0
        END
    ) AS Leave_Days,

    ROUND(
        SUM(
            CASE
                WHEN a.Status = 'Present' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(a.Attendance_ID),
        2
    ) AS Attendance_Percentage,

    ROUND(AVG(a.Work_Hours), 2) AS Average_Work_Hours

FROM EmployeeTab e

JOIN Department d
    ON e.Department_ID = d.Department_ID

JOIN Salary s
    ON e.Employee_ID = s.Employee_ID

JOIN Performance p
    ON e.Employee_ID = p.Employee_ID

JOIN Attendance a
    ON e.Employee_ID = a.Employee_ID

GROUP BY
    e.Employee_ID,
    e.Employee_Name,
    e.Gender,
    e.Job_Title,
    e.Education_Level,
    e.Experience_Years,
    d.Department_Name,
    d.Location,
    e.Employment_Status,
    s.Monthly_Salary,
    s.Bonus,
    s.Salary_Year,
    p.Review_Date,
    p.Performance_Score,
    p.Productivity_Score,
    p.Quality_Score,
    p.Teamwork_Score,
    p.Overall_Rating;
    SELECT *
FROM Employee_Workforce_Analytics;
SHOW TABLES;
DESCRIBE Performance;

USE EmployeeWorkforceDB;

SELECT 
    MIN(Review_Date) AS Oldest_Date,
    MAX(Review_Date) AS Latest_Date,
    COUNT(*) AS Total_Records
FROM Performance;

SET SQL_SAFE_UPDATES = 0;

UPDATE Performance
SET Review_Date =
    DATE_ADD(
        '2023-01-15',
        INTERVAL MOD(Employee_ID - 1001, 48) MONTH
    );

SET SQL_SAFE_UPDATES = 1;
SELECT 
    MIN(Review_Date) AS Oldest_Date,
    MAX(Review_Date) AS Latest_Date,
    COUNT(*) AS Total_Records
FROM Performance;
SELECT 
    YEAR(Review_Date) AS Year,
    MONTH(Review_Date) AS Month,
    COUNT(*) AS Review_Count
FROM Performance
GROUP BY YEAR(Review_Date), MONTH(Review_Date)
ORDER BY Year, Month;