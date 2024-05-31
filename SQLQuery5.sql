--read all employees
CREATE PROCEDURE SP_GETALLDATA
AS
BEGIN
SELECT Id,FirstName,LastName,DateOfBirth,Email,Salary from Employees with(nolock)
END

--data get by id
create procedure sp_getemployeebyId
@Id int
as
begin
SELECT Id,FirstName,LastName,DateOfBirth,Email,Salary from Employees with(nolock) where Id=@Id;

end

--insert data
create procedure sp_insert_employeedata
(
@FirstName varchar(50),
@LastName varchar (50),
@DateOfBirth datetime,
@Email nvarchar (50),
@Salary float)

AS
BEGIN
BEGIN TRY
BEGIN TRAN
INSERT INTO employees (FirstName,LastName,DateOfBirth,Email,Salary) 
values (
@FirstName,
@LastName ,
@DateOfBirth,
@Email,
@Salary
)
COMMIT TRAN
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH

END


--upodate data
create procedure sp_updateemployeedata
(
@Id int,
@FirstName varchar(50),
@LastName varchar (50),
@DateOfBirth datetime,
@Email nvarchar (50),
@Salary float)

as
begin
declare @RowCount INT=0
BEGIN
TRY
SET @RowCount=(SELECT COUNT(1)FROM Employess with (nolock)where Id=@Id)
IF (@RowCount>0)
BEGIN
BEGIN TRAN

UPDATE Employees
set
FirstName    = @FirstName   
,LastName     = @LastName
,DateOfBirth  = @DateOfBirth 
,Email        = @Email 
,Salary       = @Salary 
where Id =@Id;

COMMIT TRAN


END
END TRY
BEGIN CATCH
ROLLBACK TRAN
END CATCH

END


--DELETE data
create procedure sp_deleteemployeedata
(
@Id int)


as
begin
declare @RowCount INT=0
BEGIN
TRY
SET @RowCount=(SELECT COUNT(1)FROM Employess with (nolock)where Id=@Id)
IF (@RowCount>0)
BEGIN
BEGIN TRAN

delete from Employees
where Id =@Id;

COMMIT TRAN


END
END TRY
BEGIN CATCH
ROLLBACK TRAN
END CATCH

END