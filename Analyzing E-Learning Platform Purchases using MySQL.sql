CREATE DATABASE Elearning_Project;
Use Elearning_project;

CREATE TABLE Learners( 
        Learner_id INT PRIMARY KEY,
        FULL_NAME VARCHAR(100) NOT NULL,
        Country VARCHAR(50) NOT NULL
        );
        
CREATE TABLE Courses (
        Course_id INT PRIMARY KEY,
        Course_name VARCHAR(100) NOT NULL,
        Category VARCHAR(50),
        Unit_price DECIMAL(10,2)
        );
        
CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    learner_id INT,
    course_id INT,
    quantity INT,
    purchase_date DATE,
    FOREIGN KEY (learner_id) REFERENCES learners(learner_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

 INSERT INTO learners VALUES
(1, 'Siva Ranjani', 'India'),
(2, 'Arun Kumar', 'India'),
(3, 'John Smith', 'USA'),
(4, 'Priya Sharma', 'India'),
(5, 'Emma Watson', 'UK');

INSERT INTO courses VALUES
(101, 'SQL Basics', 'Data Analytics', 500.00),
(102, 'Python Programming', 'Programming', 800.00),
(103, 'Power BI', 'Data Analytics', 700.00),
(104, 'Excel Mastery', 'Business', 400.00),
(105, 'Web Development', 'Programming', 900.00); 


INSERT INTO purchases VALUES
(1, 1, 101, 2, '2025-01-10'),
(2, 1, 102, 1, '2025-01-15'),
(3, 2, 103, 3, '2025-02-01'),
(4, 3, 101, 1, '2025-02-10'),
(5, 4, 104, 2, '2025-03-05'),
(6, 5, 105, 1, '2025-03-10'),
(7, 2, 102, 2, '2025-03-15'),
(8, 3, 103, 1, '2025-03-20');

SELECT 
    l.full_name AS learner_name,
    l.country,
    c.course_name,
    c.category,
    p.quantity,
    FORMAT(p.quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date
FROM purchases p
INNER JOIN learners l ON p.learner_id = l.learner_id
INNER JOIN courses c ON p.course_id = c.course_id
ORDER BY total_amount DESC;

SELECT 
    l.full_name,
    c.course_name
FROM learners l
LEFT JOIN purchases p ON l.learner_id = p.learner_id
LEFT JOIN courses c ON p.course_id = c.course_id;

SELECT 
    c.course_name,
    l.full_name
FROM purchases p
RIGHT JOIN courses c ON p.course_id = c.course_id
LEFT JOIN learners l ON p.learner_id = l.learner_id;

SELECT 
    l.full_name,
    l.country,
    FORMAT(SUM(p.quantity * c.unit_price), 2) AS total_spent
FROM purchases p
JOIN learners l ON p.learner_id = l.learner_id
JOIN courses c ON p.course_id = c.course_id
GROUP BY l.full_name, l.country
ORDER BY total_spent DESC;

SELECT 
   c.course_name,
   SUM(p.quantity) AS total_quantity
FROM purchases p 
JOIN courses c ON p.course_id = c.course_id
GROUP BY c.course_name
ORDER BY total_quantity DESC
LIMIT 3;

SELECT 
   c.category,
   FORMAT(SUM(p.quantity * c.unit_price),2) AS total_revenue,
   COUNT(distinct p.learner_id) AS unique_learners
FROM purchases p
JOIN courses c ON p.course_id = c.course_id
GROUP BY c.category;

SELECT 
   l.full_name
FROM purchases p
JOIN learners l ON p.learner_id = l.learner_id
JOIN courses c ON p.course_id = c.course_id
GROUP BY l.full_name
HAVING COUNT(DISTINCT c.category) >1;

SELECT
  c.course_name
FROM courses c 
LEFT JOIN purchases p ON c.course_id = p.course_id
WHERE p.purchase_id IS NULL;
