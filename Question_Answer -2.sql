use company;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    grade INT,
    city VARCHAR(50)
);

INSERT INTO students (student_id, name, age, grade, city) VALUES
(1, 'Alice', 14, 9, 'New York'),
(2, 'Bob', 15, 10, 'Los Angeles'),
(3, 'Charlie', 14, 9, 'Chicago'),
(4, 'David', 16, 11, 'Houston'),
(5, 'Eve', 15, 10, 'Phoenix'),
(6, 'Frank', 17, 12, 'Philadelphia'),
(7, 'Grace', 16, 11, 'San Diego'),
(8, 'Henry', 14, 9, 'Dallas'),
(9, 'Isabel', 17, 12, 'San Francisco'),
(10, 'Jack', 15, 10, 'Seattle');

select * from students;

-- Q. Select all students who are in grade 10.
select * from students where grade=10;

-- Q. Find the average age of students in each grade.
select avg(age) as Avg_age from students 
group by grade;

-- Q. List the students who live in cities starting with the letter 'S'.
select * from students where city like 'S%';

-- Q. Retrieve the number of students in each city.
select city,count(name) as no_of_students from students
group by city;

-- Q. Find students who are older than 15 and in grade 11 or higher.
select * from students 
where age>15 and grade<11;

-- Q. Display the names of students who are not from New York.
select * from students
where city!='New York';

-- Q. Sort the list of students by age in descending order.
select * from students order by age desc;

-- Q. Count the total number of students who are 14 years old.
select age,count(name) as total_stu from students
where age=14;

-- Q. Retrieve the details of students whose names have exactly five letters.
select * from students where length(name)=5;

-- Q.List all unique grades present in the table.
select distinct(grade) as unique_grade from students;

-- Q.Find the youngest student in each grade.
select grade,min(age) as min_age from students
group by grade;

-- Q. Show students whose age is between 14 and 16, inclusive.
select * from students
where age between 14 and 16;

-- Q. Display the total number of students in the entire table.
select count(name) as total_students from students;

-- Q. Find students who live in either Los Angeles, Chicago, or Phoenix.
select * from students
where city in ('Los Angeles','Chicago','Phoenix');

-- Q. Retrieve the names of students who are in grade 12 and older than 16.
select * from students 
where grade=12 and age>16;


