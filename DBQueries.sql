USE people;

-- Zapytanie A. Znajd� imi� i nazwisko osoby posiadaj�cej najwi�ksz� liczb� wnucz�t p�ci �e�skiej.
WITH Children AS (
    SELECT R.ChildId, COUNT(*) AS FemaleGrandchildrenCount
    FROM Relationship R
    JOIN Person P ON R.ChildId = P.PersonId
    WHERE P.Sex = 'F'
    GROUP BY R.ChildId
),
GrandchildrenCount AS (
    SELECT R.ParentId, MAX(C.FemaleGrandchildrenCount) AS MaxFemaleGrandchildrenCount
    FROM Relationship R
    JOIN Children C ON R.ChildId = C.ChildId
    GROUP BY R.ParentId
)
SELECT TOP 2 P.FirstName + ' ' + P.LastName AS 'Ma��e�stwo z najwi�ksz� liczb� wnucz�t p�ci �e�skiej'
FROM GrandchildrenCount GC
JOIN Person P ON GC.ParentId = P.PersonId
ORDER BY GC.MaxFemaleGrandchildrenCount DESC;

-- Zapytanie B. Przedstaw �redni� ilo�� pracownik�w zatrudnionych na umow� zlecenie i �redni� ilo�� pracownik�w
-- zatrudnionych na umow� o prac� we wszystkich firmach oraz �redni� pensj� dla tych um�w.
WITH ContractCounts AS (
    SELECT
        C.CompanyName,
        COUNT(DISTINCT MC.ContractId) AS NumMandateContracts,
        COUNT(DISTINCT EC.ContractId) AS NumEmploymentContracts,
        AVG(EC.Salary) AS AvgEmploymentSalary,
        AVG(MC.EstimateHours * MC.HourlyRate) AS AvgMandateSalary
    FROM
        Company C
        LEFT JOIN Contract CO ON C.CompanyId = CO.CompanyId
        LEFT JOIN MandateContract MC ON CO.ContractId = MC.ContractId
        LEFT JOIN EmploymentContract EC ON CO.ContractId = EC.ContractId
    GROUP BY
        C.CompanyName
)
SELECT
    AVG(NumMandateContracts) AS AvgNumMandateContracts,
    AVG(NumEmploymentContracts) AS AvgNumEmploymentContracts,
    AVG(AvgMandateSalary) AS AvgMandateSalary,
    AVG(AvgEmploymentSalary) AS AvgEmploymentSalary
FROM
    ContractCounts;

-- Zapytanie C. Znajd� rodzin� (co najwy�ej 2 pokoleniow�) najmniej zarabiaj�c�. Przedstaw imi� i nazwisko dowolnej osoby
-- z tej rodziny.
WITH FamilyMembers AS (
    SELECT P.PersonId, P.FirstName, P.LastName
    FROM Person P
    WHERE P.PersonId IN (
        SELECT ParentId FROM Relationship  -- dzieci (pokolenie 1)
        UNION
        SELECT ChildId FROM Relationship  -- wnuki (pokolenie 2)
    )
),
FamilyIncomes AS (
    SELECT 
        FM.PersonId, 
        FM.FirstName, 
        FM.LastName,
        SUM(EC.Salary) AS TotalEmploymentIncome,
        SUM(MC.HourlyRate * MC.EstimateHours) AS TotalMandateIncome
    FROM FamilyMembers FM
    LEFT JOIN Contract C ON FM.PersonId = C.PersonId
    LEFT JOIN EmploymentContract EC ON C.ContractId = EC.ContractId
    LEFT JOIN MandateContract MC ON C.ContractId = MC.ContractId
    GROUP BY FM.PersonId, FM.FirstName, FM.LastName
),
SummedFamilyIncomes AS (
    SELECT 
        LEFT(LastName, LEN(LastName) - 1) AS LastNameComparison,
        SUM(TotalEmploymentIncome) AS TotalEmploymentIncome,
        SUM(TotalMandateIncome) AS TotalMandateIncome
    FROM FamilyIncomes
    GROUP BY LEFT(LastName, LEN(LastName) - 1)
),
RankedFamilyIncomes AS (
    SELECT 
        FirstName + ' ' + LastName AS 'Osoba z rodziny najmniej zarabiaj�cej',
        SFI.TotalEmploymentIncome + SFI.TotalMandateIncome AS TotalFamilyIncome,
        ROW_NUMBER() OVER (ORDER BY SFI.TotalEmploymentIncome + SFI.TotalMandateIncome ASC) AS RowNum
    FROM FamilyIncomes FI
    JOIN SummedFamilyIncomes SFI ON LEFT(FI.LastName, LEN(FI.LastName) - 1) = SFI.LastNameComparison
)
SELECT *
FROM RankedFamilyIncomes
WHERE RowNum = 1;






