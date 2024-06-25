CREATE DATABASE University;
CREATE TABLE People
(
	PersonID     INTEGER        PRIMARY KEY		IDENTITY(1,1),
	FirstName    VARCHAR(50)    NOT NULL,
    LastName     VARCHAR(50)    NOT NULL,
	Password     VARCHAR(50),
	DOB          DATE           NOT NULL,
	SSN          VARCHAR(11),
);

CREATE TABLE CourseCatalogue
(
	CourseCode   VARCHAR(20) NOT NULL,
	CourseNumber INTEGER     NOT NULL,
	PRIMARY KEY (CourseCode,CourseNumber),
	CourseTitle  VARCHAR(50) NOT NULL,
	CourseDesc   VARCHAR(500) 
);

CREATE TABLE CourseSchedule
(
	CourseScheduleID INTEGER     PRIMARY KEY IDENTITY(1,1),
	CourseCode       VARCHAR(20) NOT NULL,
	CourseNumber	 INTEGER     NOT NULL,
	FOREIGN KEY(CourseCode,CourseNumber)  REFERENCES CourseCatalogue(CourseCode, CourseNumber),
	NumberOfSeats    INTEGER     NOT NULL CHECK(NumberOfSeats>=0),	
);

CREATE TABLE JobInformation
( 
	JobID           INTEGER        PRIMARY KEY    IDENTITY(1,1),
	JobDescription  VARCHAR(500)   NOT NULL,
	JobRequirements VARCHAR(500),
	MinPay          DECIMAL(10,2)  NOT NULL       CHECK  (Minpay >= 0),
    MaxPay          DECIMAL(10,2)  NOT NULL       CHECK  (Maxpay >= 0),

);

CREATE TABLE EmployeeInfo
(
	EmployeeID     VARCHAR(20)    PRIMARY KEY,
	PersonID       INTEGER        NOT NULL       REFERENCES People(PersonID),
	YearlyPay      DECIMAL(10,2)  NOT NULL,
	JobInformation InTEGER        NOT NULL       REFERENCES JobInformation(JobID)
);

CREATE TABLE Grades
(
	GradeID	    INTEGER	       PRIMARY KEY	 IDENTITY(1,1),
	Grade		VARCHAR(20)	   NOT NULL		 UNIQUE
);

CREATE TABLE StudentStatus 
(
	StudentStatusID      INTEGER	    PRIMARY KEY	   IDENTITY(1,1),
	StudentStatus		 VARCHAR(80)	NOT NULL
);

CREATE TABLE StudentInfo 
(
	StudentID				INTEGER	    PRIMARY KEY    IDENTITY(1,1),
	PersonID				INTEGER 	NOT NULL       REFERENCES     People(PersonID),
	StudentStatusID			INTEGER					   REFERENCES     StudentStatus(StudentStatusID)	
);


CREATE TABLE TeachingAssignment
(
	EmployeeID           VARCHAR(20)     NOT NULL	  REFERENCES EmployeeInfo(EmployeeID),
	CourseScheduleID     INTEGER         NOT NULL     REFERENCES CourseSchedule(CourseScheduleID) ,
	PRIMARY KEY (EmployeeID, CourseScheduleID)
);

CREATE TABLE CourseEnrollment
(
	EnrollmentID	INTEGER	        PRIMARY KEY,
	CourseID	    INTEGER	        NOT NULL      REFERENCES    CourseSchedule(CourseScheduleID),
	StudentID	    INTEGER	        NOT NULL      REFERENCES    StudentInfo(StudentID),

	GradeID	        INTEGER	                      REFERENCES    Grades(GradeID)
);

CREATE TABLE Buildings
(
	ID				INTEGER      PRIMARY KEY   IDENTITY(1,1),
	BuildingName	VARCHAR(80)  NOT NULL
);

--SELECT * FROM CourseCatalogue
INSERT INTO CourseCatalogue VALUES('CS','702','Integer Optimization','Introduces optimization problems over integers, and surveys the theory behind the algorithms used in state-of-the-art methods for solving such problems.')
INSERT INTO CourseCatalogue VALUES('CS','612','Machine Learning','Computational approaches to learning: including inductive inference, explanation-based learning, analogical learning, connectionism, and formal models.')
INSERT INTO CourseCatalogue VALUES('EE','632','VLSI Systems Design','Overview of MOS devices and circuits; introduction to integrated circuit fabrication; topological design of data flow and control; interactive graphics layout; circuit simulation; system timing; organizational and architectural considerations; alternative implementation approaches')
INSERT INTO CourseCatalogue VALUES('EE','662','Advanced Computer Architecture','Advanced techniques of computer design. Parallel processing and pipelining; multiprocessors, multi-computers and networks; high performance machines and special purpose processors; data flow architecture.')
INSERT INTO CourseCatalogue VALUES('CS','772','Distributed Systems','distributed programming; distributed file systems; atomic actions; fault tolerance, transactions, program & data replication, recovery; distributed machine architectures; security and authentication')
INSERT INTO CourseCatalogue VALUES('CS','692','Dynamic Programming','A generalized optimization model; discrete and continuous state spaces; deterministic and stochastic transition functions. Multistage decision processes. Functional equations and successive approximation in function ')
INSERT INTO CourseCatalogue VALUES('MAE','111','Energy Conversion','Energy demand and resources. Fundamentals of combustion. Power plants, refrigeration systems. Turbines and engines.')
INSERT INTO CourseCatalogue VALUES('CE','775','Distributed Objects','Design and implement software components using the Component Object Model (COM).')


--SELECT * FROM Grades
INSERT INTO Grades(Grade)VALUES
('A'),
('B'),
('C'),
('D');

--SELECT * FROM JobInformation
INSERT INTO JobInformation (JobDescription,JobRequirements,MinPay,MaxPay) VALUES
('Professor','Minimum Qualification is PhD and a minimum of 5 years teaching experience',2000.00,50000.00),
('Assistant Professor','Minimum Qualification is PhD and a minimum of 2 years teaching experience', 10000.00,80000.00),
('Visiting Professor','Minimum Qualification is PhD and a minimum of 2 years Industry experience',6000.00,60000.00),
('Lecturer','Minimum of a bachelor degree in an academic field of study',10000.00,90000.00),
('Research Professor','Minimum of a doctoral degree in an academic field of study and a minimum of 4 years research experience',7000.00,45000.00),
('Teaching Assistant','Minimum of a bachelor degree in an academic field of study and persuing doctoral degree',10000.00,95000.00)

--Professors/employees
--SELECT * FROM People
INSERT INTO People (FirstName, LastName, Password, DOB , SSN ) VALUES
('Scooby','Doo','Hello123','20080618 10:34:09 AM','102-02-1992'),
('Shaggy','Rogers',NULL, '19930413 10:34:09 AM','1AB-01-1912'),
('Fred','Jones',NULL, '19920609 10:55:10 AM','113-0B-19LK'),
('Daphne','Blake','Shaggy221', '19900218 09:34:09 AM','FHJ-59-5759' ),
('Velma','Dinkley','11Velm12', '19921020 08:30:09 AM','HJC-36-8430'),
('Yabba','Doo',NULL, '19900719 04:17:19 AM','475-47-SGFC')



--SELECT * FROM StudentStatus
INSERT INTO StudentStatus (StudentStatus) VALUES 
('Full-Time'),
('Part-Time'),
('Voluntary Withdrawal'),
('Expelled');


--SELECT * FROM EmployeeInfo
INSERT INTO EmployeeInfo (EmployeeID, PersonID , YearlyPay , JobInformation) VALUES
('01-PR', 1, 23000.00  , 4),
('02-TA', 2 , 10000.00  , 6),
('03-TS', 3 , 50000.00  , 2),
('04-FA', 4 , 3000.00  , 1),
('05-AA', 5 , 40000.00 , 6),
('10-GI', 6 , 5000.00  , 3);

--SELECT * FROM StudentInfo
INSERT INTO StudentInfo (PersonID, StudentStatusID) VALUES
(3,4),
(4,3),
(6,3),
(1,1),
(5,2),
(2,4);


--SELECT * FROM CourseSchedule
INSERT INTO CourseSchedule (CourseCode,CourseNumber,NumberOfSeats) VALUES 
('CS', 612 ,50),
('CS', 692 ,60),
('EE', 632 ,25),
('EE', 662 ,35),
('CS', 702 ,45),
('CS', 772 ,15),
('MAE', 111 ,30),
('CE', 775 , 30 );

--SELECT * FROM TeachingAssignment

INSERT INTO TeachingAssignment (EmployeeID,CourseScheduleID) VALUES
('01-PR',1),
('02-TA',2),
('03-TS',3),
('04-FA',4),
('05-AA',5),
('10-GI',6);

--SELECT * FROM CourseEnrollment
INSERT INTO CourseEnrollment (EnrollmentID,CourseID,StudentID,GradeID) VALUES
(200,1,1,1),
(201,2,1,NULL),
(202,3,3,4),
(203,4,4,2),
(204,5,5,NULL),
(205,6,2,1),
(206,2,6,NULL);

INSERT INTO Buildings (BuildingName) VALUES
('Crouse College'),
('Hall of Languages'),
('Hendricks Chapel'),
('Center for Science and Technology'),
('Newhouse Communications Center'),
('Slutzker Center');

select * from Grades;

select FirstName , CourseCode , JobDescription
from People ,CourseSchedule, EmployeeInfo, TeachingAssignment , JobInformation
WHERE  People.PersonID =EmployeeInfo.PersonID 
and EmployeeInfo.EmployeeID=TeachingAssignment.EmployeeID 
and TeachingAssignment.CourseScheduleID=CourseSchedule.CourseScheduleID 
and EmployeeInfo.JobInformation = JobInformation.JobID
and CourseSchedule.CourseScheduleID = 1 ;






