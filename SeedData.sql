USE people;

INSERT INTO Person (SpouseId, PESEL, FirstName, LastName, BirthDate, Sex, Salary)
VALUES
	   (2, '12345678901', 'Jan', 'Kowalski', '1948-05-15', 'M', 20000.00), -- 1
	   (1, '11122233355', 'Joanna', 'Kowalska', '1954-07-25', 'F', NULL), -- 2

       (4, '22233344466', 'Ewa', 'Kowalska', '1973-09-12', 'F', 6000.00), -- 3
       (3, '44455566677', 'Tomasz', 'Kowalski', '1978-11-30', 'M', 5800.00), -- 4

	   (NULL, '65478932100', 'El¿bieta', 'Kowalska', '2000-08-22', 'F', 5900.00), -- 5
       (NULL, '78965432100', '£ukasz', 'Kowalski', '1999-12-01', 'M', 6400.00), -- 6
       (NULL, '45698712300', 'Kinga', 'Kowalska', '2010-05-17', 'F', NULL), -- 7


       (9, '98765432109', 'Anna', 'Nowak', '1957-08-20', 'F', 10000.00), -- 8
	   (8, '11122233344', 'Piotr', 'Nowak', '1955-12-10', 'M', NULL), -- 9

	   (NULL, '77788899900', 'Alicja', 'Nowak', '1980-02-18', 'F', NULL), -- 10
       (NULL, '99900011122', 'Karolina', 'Nowak', '1986-06-05', 'F', NULL), -- 11 
       (NULL, '12398745600', 'Marek', 'Nowak', '1982-03-08', 'M', NULL), -- 12


       (14, '55566677788', 'Maria', 'Lis', '1958-04-03', 'F', NULL), -- 13
	   (13, '95175346800', 'Bartosz', 'Lis', '1958-12-18', 'M', NULL), -- 14

       (16, '35715986400', 'Aleksandra', 'Lis', '1983-01-05', 'F', NULL), -- 15
	   (15, '98765412300', 'Micha³', 'Lis', '1983-09-28', 'M', NULL), -- 16

	   (18, '32165498700', 'Patrycja', 'Lis', '1999-07-14', 'F', NULL), -- 17
       (17, '85274196300', 'Grzegorz', 'Lis', '1997-02-03', 'M', NULL), -- 18

       (NULL, '36985214700', 'Sylwia', 'Lis', '2008-04-20', 'F', NULL), -- 19
       (NULL, '15975348600', 'Jakub', 'Lis', '2009-10-10', 'M', NULL), -- 20
       (NULL, '65412398700', 'Natalia', 'Lis', '2015-11-27', 'F', NULL); -- 21


INSERT INTO Parent (PersonId)
VALUES (1),
       (2),
       (3),
	   (4),
	   (8),
	   (9),
	   (13),
	   (14),
	   (15),
	   (16),
	   (17),
	   (18);


INSERT INTO Relationship (ParentId, ChildId)
VALUES 
		(1, 3),
		(1, 4),
		(2, 3),
		(2, 4),
		(3, 5),
		(3, 6),
		(3, 7),
		(4, 5),
		(4, 6),
		(4, 7),
		(8, 10),
		(8, 11),
		(8, 12),
		(9, 10),
		(9, 11),
		(9, 12),
		(13, 15),
		(14, 15),
		(13, 18),
		(14, 18),
		(17, 19),
		(17, 20),
		(17, 21),
		(18, 19),
		(18, 20),
		(18, 21);


INSERT INTO Company (PresidentId, CompanyName)
VALUES (1, 'The Best Industry'),
	   (8, 'Hyper Industries');

INSERT INTO Contract (PersonId, CompanyId, StartDate, EndDate)
VALUES (1, 1, '2023-01-01', '2024-01-01'),
       (3, 1, '2022-03-15', '2023-03-15'),
       (4, 1, '2022-06-01', '2023-06-01'),
       (5, 1, '2023-02-01', '2024-02-01'),
       (6, 1, '2022-09-01', '2023-09-01'),

       (8, 2, '2023-01-01', '2024-01-01'),
       (10, 2, '2022-12-15', '2023-12-15'),
       (11, 2, '2023-03-01', '2024-03-01'),
       (12, 2, '2023-04-01', '2024-04-01'),
       (13, 2, '2023-05-01', '2024-05-01'),

       (14, 2, '2023-06-01', '2024-06-01'),
       (15, 2, '2023-07-01', '2024-07-01'),
       (16, 2, '2023-08-01', '2024-08-01'),
       (17, 2, '2023-09-01', '2024-09-01'),
       (18, 2, '2023-10-01', '2024-10-01');


INSERT INTO EmploymentContract (ContractId, Position, Salary, JobSize)
VALUES (1, 'President', 20000.00, '180h'),
       (2, 'Project Manager', 6000.00, '180h'),
       (3, 'IT Specialist', 5800.00, '180h'),
	   (4, 'Sales Manager', 5900.00, '180h'),
       (5, 'Financial Analyst', 6400.00, '180h'),
	   (6, 'President', 10000.00, '180h');

INSERT INTO MandateContract (ContractId, HourlyRate, EstimateHours, JobDescription)
VALUES (7, 75.00, 100, 'Developing new features for the company''s software product'),
       (8, 60.00, 80, 'Planning and executing marketing campaigns'),
       (11, 85.00, 120, 'Managing multiple projects and teams'),
       (12, 70.00, 90, 'Handling recruitment and employee relations'),
       (13, 80.00, 110, 'Designing and implementing sales strategies'),
       (14, 65.00, 95, 'Financial analysis and reporting'),
       (15, 90.00, 130, 'Providing customer service and support');

