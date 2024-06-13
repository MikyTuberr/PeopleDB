USE people;
GO

CREATE TABLE Person (
    PersonId INT IDENTITY(1,1) PRIMARY KEY,
    SpouseId INT NULL,
    PESEL VARCHAR(11) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    Sex CHAR(1) NOT NULL CHECK (Sex IN ('M', 'F')),
    Salary DECIMAL(10, 2) NULL,
    FOREIGN KEY (SpouseId) REFERENCES Person(PersonId)
);

CREATE TABLE Parent (
    PersonId INT PRIMARY KEY,
    FOREIGN KEY (PersonId) REFERENCES Person(PersonId)
);

CREATE TABLE Relationship (
    ParentId INT NOT NULL,
    ChildId INT NOT NULL,
    FOREIGN KEY (ParentId) REFERENCES Parent(PersonId),
    FOREIGN KEY (ChildId) REFERENCES Person(PersonId),
    PRIMARY KEY (ParentId, ChildId)
);

CREATE TABLE Company (
    CompanyId INT IDENTITY(1,1) PRIMARY KEY,
	CompanyName VARCHAR(50),
    PresidentId INT NULL,
    FOREIGN KEY (PresidentId) REFERENCES Person(PersonId)
);

CREATE TABLE Contract (
    ContractId INT IDENTITY(1,1) PRIMARY KEY,
    PersonId INT NOT NULL,
    CompanyId INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
	CONSTRAINT CHK_DateRange CHECK (StartDate < EndDate),
    FOREIGN KEY (PersonId) REFERENCES Person(PersonId),
    FOREIGN KEY (CompanyId) REFERENCES Company(CompanyId)
);

CREATE TABLE EmploymentContract (
    ContractId INT PRIMARY KEY,
    Position VARCHAR(100) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    JobSize VARCHAR(5) NOT NULL,
    FOREIGN KEY (ContractId) REFERENCES Contract(ContractId)
);

CREATE TABLE MandateContract (
    ContractId INT PRIMARY KEY,
    HourlyRate DECIMAL(10, 2) NOT NULL,
    EstimateHours INT NOT NULL,
    JobDescription TEXT NOT NULL,
    FOREIGN KEY (ContractId) REFERENCES Contract(ContractId)
);
