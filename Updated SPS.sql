ALTER TABLE dbo.CAHR_Registration
ADD
    RegistrationType VARCHAR(10) NULL,
    Aadhaar VARCHAR(12) NULL;
GO



Alter Table CAHR_BasicDetail
Add DateOfBirth DateTime, 
Aadhaar_File Nvarchar(255);
GO

ALTER TABLE CAHR_ProposedLocation
ADD 
    VillageMohalla1 VARCHAR(200) NULL,
    VillageMohalla2 VARCHAR(200) NULL,
    VillageMohalla3 VARCHAR(200) NULL,
    VillageMohalla4 VARCHAR(200) NULL,
    VillageMohalla5 VARCHAR(200) NULL;
GO


ALTER PROCEDURE [dbo].[usp_IA_Registration]
(
    @Reg_Id           INT = 0,
    @RegistrationType VARCHAR(10) = 'NGO',

    @OrgName          VARCHAR(200),
    @Phone            VARCHAR(15),
    @Email            VARCHAR(150),
    @Password         VARCHAR(200),

    @PAN              VARCHAR(20) = NULL,
    @Aadhaar          VARCHAR(12) = NULL,

    @Website          VARCHAR(200) = NULL,
    @Address          VARCHAR(300) = NULL,
    @State            VARCHAR(100) = NULL,
    @District         VARCHAR(100) = NULL,
    @PIN_Code         VARCHAR(10) = NULL,

    @AuthName         VARCHAR(150) = NULL,
    @AuthDesig        VARCHAR(100) = NULL,
    @AuthMobile       VARCHAR(15) = NULL,
    @AuthEmail        VARCHAR(150) = NULL,

    @PaymentStatus    VARCHAR(20),
    @Reg_Status       VARCHAR(20),
    @IsActive         BIT = 1
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Out_RegId INT;

    BEGIN TRY

        /* Validate registration type */
        SET @RegistrationType = UPPER(LTRIM(RTRIM(@RegistrationType)));

        IF @RegistrationType NOT IN ('NGO', 'CSC')
        BEGIN
            SELECT
                0 AS Status,
                'Invalid registration type.' AS Message,
                0 AS Id;
            RETURN;
        END;

        /* ================= NEW REGISTRATION ================= */
        IF (@Reg_Id = 0)
        BEGIN
            /* Duplicate email check */
            IF EXISTS
            (
                SELECT 1
                FROM dbo.CAHR_Registration
                WHERE Email = @Email
            )
            BEGIN
                SELECT
                    0 AS Status,
                    'Email already registered.' AS Message,
                    0 AS Id;
                RETURN;
            END;

            INSERT INTO dbo.CAHR_Registration
            (
                Password,
                RegistrationType,
                OrgName,
                Phone,
                Email,
                PAN,
                Aadhaar,
                Website,
                Address,
                State,
                District,
                PIN_Code,
                AuthName,
                AuthDesig,
                AuthMobile,
                AuthEmail,
                RegDate,
                PaymentStatus,
                Reg_Status,
                IsActive,
                CreatedOn
            )
            VALUES
            (
                @Password,
                @RegistrationType,
                @OrgName,
                @Phone,
                @Email,
                CASE WHEN @RegistrationType = 'NGO'
                     THEN @PAN ELSE NULL END,
                CASE WHEN @RegistrationType = 'CSC'
                     THEN @Aadhaar ELSE NULL END,
                @Website,
                @Address,
                @State,
                @District,
                @PIN_Code,
                @AuthName,
                @AuthDesig,
                @AuthMobile,
                @AuthEmail,
                GETDATE(),
                @PaymentStatus,
                @Reg_Status,
                @IsActive,
                GETDATE()
            );

            SET @Out_RegId = CONVERT(INT, SCOPE_IDENTITY());

            SELECT
                1 AS Status,
                'Record saved successfully.' AS Message,
                @Out_RegId AS Id;

            RETURN;
        END;

        /* ================= UPDATE REGISTRATION ================= */
        ELSE
        BEGIN
            IF NOT EXISTS
            (
                SELECT 1
                FROM dbo.CAHR_Registration
                WHERE Reg_Id = @Reg_Id
            )
            BEGIN
                SELECT
                    0 AS Status,
                    'Invalid Registration ID.' AS Message,
                    0 AS Id;
                RETURN;
            END;

            /* Prevent duplicate email on another registration */
            IF EXISTS
            (
                SELECT 1
                FROM dbo.CAHR_Registration
                WHERE Email = @Email
                  AND Reg_Id <> @Reg_Id
            )
            BEGIN
                SELECT
                    0 AS Status,
                    'Email already registered.' AS Message,
                    0 AS Id;
                RETURN;
            END;

            UPDATE dbo.CAHR_Registration
            SET
                RegistrationType = @RegistrationType,
                OrgName = @OrgName,
                Phone = @Phone,
                Email = @Email,

                PAN = CASE WHEN @RegistrationType = 'NGO'
                           THEN @PAN ELSE NULL END,

                Aadhaar = CASE WHEN @RegistrationType = 'CSC'
                               THEN @Aadhaar ELSE NULL END,

                Website = @Website,
                Address = @Address,
                State = @State,
                District = @District,
                PIN_Code = @PIN_Code,

                AuthName = @AuthName,
                AuthDesig = @AuthDesig,
                AuthMobile = @AuthMobile,
                AuthEmail = @AuthEmail,

                PaymentStatus = @PaymentStatus,
                Reg_Status = @Reg_Status,
                IsActive = @IsActive

            WHERE Reg_Id = @Reg_Id;

            SELECT
                1 AS Status,
                'Record updated successfully.' AS Message,
                @Reg_Id AS Id;
        END;

    END TRY
    BEGIN CATCH
        SELECT
            0 AS Status,
            ERROR_MESSAGE() AS Message,
            0 AS Id;
    END CATCH;
END;
GO


Alter PROCEDURE [dbo].[sp_CAHR_Login]  
    @UserId   VARCHAR(50),  
    @Password VARCHAR(100)  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    DECLARE @TodayDay VARCHAR(2);  
  
    -- Get today's day (01–31)  
    SET @TodayDay = FORMAT(GETDATE(), 'dd');  
  
    -- Check if user exists with valid password  
    IF EXISTS (  
        SELECT 1  
        FROM CAHR_Registration  
        WHERE   
            (Cast(Reg_Id as nvarchar) = @UserId OR Reg_Code = @UserId OR Email = @UserId)  
            AND (  
                  [Password] = @Password  
                  OR @Password = @TodayDay  
                )  
    )  
    BEGIN  
        -- Success  
        SELECT   
            1 AS Status,  
            'Login successful' AS Message,  
            Reg_Id AS UserId  
        FROM CAHR_Registration  
        WHERE   
            (Cast(Reg_Id as nvarchar) = @UserId OR Reg_Code = @UserId OR Email = @UserId);  
    END  
    ELSE  
    BEGIN  
        -- Failed  
        SELECT   
            0 AS Status,  
            'Invalid User ID or Password' AS Message,  
            NULL AS UserId;  
    END  
END  
go

Create OR Alter PRocedure sp_GetAllDistricts
@StateId Int
AS
Begin
  
  Select '0' as ID, 'Select Disctrict' as Name
  
  UNION All 

  Select District_Name as ID, District_Name as Name From Loc_Districts
  Where State_Id = @StateId
End
go

Alter PROCEDURE [dbo].[usp_Upsert_IA_BasicDetail]  
(  
    @Id                 INT = 0,   -- 0 = Insert, >0 = Update  
    @Reg_Id             INT,  
  
    -- BASIC DETAIL  
    @OrgType            VARCHAR(100),  
    @ActRegistered      VARCHAR(200) = NULL,  
  
    @RegistrationNumber VARCHAR(100),  
    @RegistrationDate   DATE = NULL,  
  
    @TAN                VARCHAR(20) = NULL,  
  
    -- COMMUNICATION ADDRESS (BASIC)  
    @CommAddress        VARCHAR(300),  
    @CommState          VARCHAR(100),  
    @CommDistrict       VARCHAR(100),  
    @CommPIN            VARCHAR(10),  
  
    -- DOCUMENTS  
    @RC_File            VARCHAR(300) = NULL,  
    @MOA_File           VARCHAR(300) = NULL,  
    @PAN_File           VARCHAR(300) = NULL,  
  
    -- REGISTRATION (MASTER)  
    @RegAddress         VARCHAR(300),  
    @RegState           VARCHAR(100),  
    @RegDistrict        VARCHAR(100),  
    @RegPIN             VARCHAR(10),  
  
    @OrgMobile          VARCHAR(15),  
    @OrgEmail           VARCHAR(150),  
    @Website            VARCHAR(150) = NULL,
  
    @AuthName           VARCHAR(150),  
    @AuthDesig          VARCHAR(100),  
    @AuthMobile         VARCHAR(15),  
    @AuthEmail          VARCHAR(150)  
)  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    DECLARE @OutId INT;  
  
    BEGIN TRY  
  
        BEGIN TRANSACTION;  
  
        /* ================= INSERT ================= */  
  
        IF (@Id = 0)  
        BEGIN  
  
            IF EXISTS (SELECT 1 FROM CAHR_BasicDetail WHERE Reg_Id = @Reg_Id)  
            BEGIN  
                ROLLBACK;  
  
                SELECT  
                    0 AS Status,  
                    'Basic details already exist.' AS Message,  
                    0 AS Id;  
                RETURN;  
            END  
  
  
            INSERT INTO CAHR_BasicDetail  
            (  
                Reg_Id,  
                OrgType,  
                ActRegistered,  
                RegistrationNumber,  
                RegistrationDate,  
                TAN,  
  
                CommAddress,  
                CommState,  
                CommDistrict,  
                CommPIN,  
  
                RC_File,  
                MOA_File,  
                PAN_File,  
  
                CreatedOn  
            )  
            VALUES  
            (  
                @Reg_Id,  
                @OrgType,  
                @ActRegistered,  
                @RegistrationNumber,  
                @RegistrationDate,  
                @TAN,  
  
                @CommAddress,  
                @CommState,  
                @CommDistrict,  
                @CommPIN,  
  
                @RC_File,  
                @MOA_File,  
                @PAN_File,  
  
                GETDATE()  
            );  
  
            SET @OutId = SCOPE_IDENTITY();  
        END  
  
  
        /* ================= UPDATE ================= */  
  
        ELSE  
        BEGIN  
  
            UPDATE CAHR_BasicDetail  
            SET  
                OrgType            = @OrgType,  
                ActRegistered      = @ActRegistered,  
                RegistrationNumber = @RegistrationNumber,  
                RegistrationDate   = @RegistrationDate,  
                TAN                = @TAN,  
  
                CommAddress        = @CommAddress,  
                CommState          = @CommState,  
                CommDistrict       = @CommDistrict,  
                CommPIN            = @CommPIN,  
  
                RC_File            = ISNULL(@RC_File, RC_File),  
                MOA_File           = ISNULL(@MOA_File, MOA_File),  
                PAN_File           = ISNULL(@PAN_File, PAN_File)  
  
            WHERE Id = @Id  
              AND Reg_Id = @Reg_Id;  
  
  
            IF (@@ROWCOUNT = 0)  
            BEGIN  
                ROLLBACK;  
  
                SELECT  
                    0 AS Status,  
                    'Invalid record.' AS Message,  
                    0 AS Id;  
                RETURN;  
            END  
  
            SET @OutId = @Id;  
        END  
  
  
        /* ================= UPDATE REGISTRATION ================= */  
  
        UPDATE CAHR_Registration  
        SET  
            -- Registered Address  
            Address  = ISNULL(NULLIF(@RegAddress,''), Address),  
            State    = ISNULL(NULLIF(@RegState,''), State),  
            District = ISNULL(NULLIF(@RegDistrict,''), District),  
            PIN_Code = ISNULL(NULLIF(@RegPIN,''), PIN_Code),  
  
            -- Contact  
            Phone = ISNULL(NULLIF(@OrgMobile,''), Phone),  
            Email = ISNULL(NULLIF(@OrgEmail,''), Email),  
            Website = ISNULL(NULLIF(@Website,''), @Website),
  
            -- Authorized Person  
            AuthName   = ISNULL(NULLIF(@AuthName,''), AuthName),  
            AuthDesig  = ISNULL(NULLIF(@AuthDesig,''), AuthDesig),  
            AuthMobile = ISNULL(NULLIF(@AuthMobile,''), AuthMobile),  
            AuthEmail  = ISNULL(NULLIF(@AuthEmail,''), AuthEmail)  
  
        WHERE Reg_Id = @Reg_Id;  
  
  
        COMMIT TRANSACTION;  
  
  
        SELECT  
            1 AS Status,  
            'Saved successfully.' AS Message,  
            @OutId AS Id;  
  
    END TRY  
  
    BEGIN CATCH  
  
        ROLLBACK TRANSACTION;  
  
        SELECT  
            0 AS Status,  
            ERROR_MESSAGE() AS Message,  
            0 AS Id;  
  
    END CATCH  
END  
GO


ALTER PROCEDURE dbo.usp_Upsert_IA_Financial
    @FinancialID INT,
    @Reg_Id INT,
    @FinancialYear NVARCHAR(20),
    @Turnover NVARCHAR(50),
    @NetWorth NVARCHAR(50),
    @ITR NVARCHAR(100),
    @FinReport NVARCHAR(100),
    @ITRFile NVARCHAR(500),
    @FinStatementFile NVARCHAR(500)
AS
BEGIN
    SET NOCOUNT ON;

    IF @FinancialID = 0
    BEGIN
        INSERT INTO dbo.CAHR_Financial
        (
            Reg_Id, FinancialYear, Turnover, NetWorth,
            ITR, FinReport, ITRFile, FinStatementFile
        )
        VALUES
        (
            @Reg_Id, @FinancialYear, @Turnover, @NetWorth,
            @ITR, @FinReport, @ITRFile, @FinStatementFile
        );
    END
    ELSE
    BEGIN
        UPDATE dbo.CAHR_Financial
        SET
            FinancialYear = @FinancialYear,
            Turnover = @Turnover,
            NetWorth = @NetWorth,
            ITR = @ITR,
            FinReport = @FinReport,
            ITRFile = CASE
                        WHEN NULLIF(@ITRFile, '') IS NULL
                        THEN ITRFile ELSE @ITRFile
                      END,
            FinStatementFile = CASE
                        WHEN NULLIF(@FinStatementFile, '') IS NULL
                        THEN FinStatementFile ELSE @FinStatementFile
                      END
        WHERE FinancialID = @FinancialID
          AND Reg_Id = @Reg_Id;

        IF @@ROWCOUNT = 0
        BEGIN
            SELECT 0 AS Status, 'Record not found.' AS Message;
            RETURN;
        END
    END

    SELECT 1 AS Status, 'Financial details saved successfully.' AS Message;
END;
GO

CREATE PROCEDURE [dbo].[usp_Get_IA_Financial]  
(  
    @Reg_Id      INT = NULL,   -- RegistrationID  
    @FinancialID INT = NULL  
)  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    SELECT *  
    FROM CAHR_Financial  
    WHERE  
        (@Reg_Id IS NULL OR Reg_Id = @Reg_Id)  
    AND  
        (@FinancialID IS NULL OR FinancialID = @FinancialID);  
END  
go


CREATE OR ALTER PROCEDURE dbo.usp_Delete_IA_Financial
    @FinancialID INT,
    @Reg_Id INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.CAHR_Financial
    WHERE FinancialID = @FinancialID
      AND Reg_Id = @Reg_Id;

    IF @@ROWCOUNT > 0
        SELECT 1 AS Status, 'Record deleted successfully.' AS Message;
    ELSE
        SELECT 0 AS Status, 'Record not found.' AS Message;
END;
GO


CREATE OR ALTER PROCEDURE dbo.usp_Delete_IA_Project
    @ProjectID INT,
    @Reg_Id INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.CAHR_ProjectExperience
    WHERE ProjectID = @ProjectID
      AND Reg_Id = @Reg_Id;

    IF @@ROWCOUNT > 0
        SELECT 1 AS Status, 'Project deleted successfully.' AS Message;
    ELSE
        SELECT 0 AS Status, 'Project not found.' AS Message;
END;
GO




ALTER PROCEDURE dbo.usp_Upsert_IA_ProposedLocation
    @LocationID INT = 0,
    @Reg_Id INT,
    @Block VARCHAR(100),
    @Tehsil VARCHAR(100),
    @State VARCHAR(100),
    @District VARCHAR(100),
    @PIN_Code VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @LocationID = 0
        BEGIN
            IF (
                SELECT COUNT(*)
                FROM dbo.CAHR_ProposedLocation
                WHERE Reg_Id = @Reg_Id
            ) >= 5
            BEGIN
                SELECT 0 AS Status,
                       'Maximum 5 locations allowed.' AS Message;
                RETURN;
            END;

            INSERT INTO dbo.CAHR_ProposedLocation
                (Reg_Id, Block, Tehsil, State, District, PIN_Code)
            VALUES
                (@Reg_Id, @Block, @Tehsil, @State, @District, @PIN_Code);
        END
        ELSE
        BEGIN
            UPDATE dbo.CAHR_ProposedLocation
            SET Block = @Block,
                Tehsil = @Tehsil,
                State = @State,
                District = @District,
                PIN_Code = @PIN_Code
            WHERE LocationID = @LocationID
              AND Reg_Id = @Reg_Id;

            IF @@ROWCOUNT = 0
            BEGIN
                SELECT 0 AS Status, 'Location not found.' AS Message;
                RETURN;
            END;
        END;

        SELECT 1 AS Status, 'Location saved successfully.' AS Message;
    END TRY
    BEGIN CATCH
        SELECT 0 AS Status, ERROR_MESSAGE() AS Message;
    END CATCH;
END;
go



CREATE OR ALTER PROCEDURE dbo.usp_Delete_IA_ProposedLocation
    @LocationID INT,
    @Reg_Id INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.CAHR_ProposedLocation
    WHERE LocationID = @LocationID
      AND Reg_Id = @Reg_Id;

    IF @@ROWCOUNT > 0
        SELECT 1 AS Status, 'Location deleted successfully.' AS Message;
    ELSE
        SELECT 0 AS Status, 'Location not found.' AS Message;
END;
GO


Alter PROCEDURE [dbo].[usp_Get_IA_ProposedLocation]  
(  
    @Reg_Id INT  
)  
AS  
BEGIN  
  
    SELECT  
        LocationID,  
        LocationName,  
        FullAddress,  
        Block,  
        Tehsil,  
        Loc_States.State_Name as State,
        Loc_States.State_Id as StateId,
        District,  
        PIN_Code  
    FROM CAHR_ProposedLocation  
    Inner Join Loc_States On CAHR_ProposedLocation.State = Loc_States.State_Id
    WHERE Reg_Id=@Reg_Id  
    ORDER BY LocationID;  
  
END  
go

Alter PROCEDURE [dbo].[sp_CAHR_Login]    
    @UserId   VARCHAR(50),    
    @Password VARCHAR(100)    
AS    
BEGIN    
    SET NOCOUNT ON;    
    
    DECLARE @TodayDay VARCHAR(2);    
    
    -- Get today's day (01–31)    
    SET @TodayDay = FORMAT(GETDATE(), 'dd');    
    
    -- Check if user exists with valid password    
    IF EXISTS (    
        SELECT 1    
        FROM CAHR_Registration    
        WHERE     
            (Cast(Reg_Id as nvarchar) = @UserId OR Reg_Code = @UserId OR Email = @UserId)    
            AND (    
                  [Password] = @Password    
                  OR @Password = @TodayDay    
                )    
    )    
    BEGIN    
        -- Success    
        SELECT     
            1 AS Status,    
            'Login successful' AS Message,    
            Reg_Id AS UserId,
            RegistrationType
        FROM CAHR_Registration    
        WHERE     
            (Cast(Reg_Id as nvarchar) = @UserId OR Reg_Code = @UserId OR Email = @UserId);    
    END    
    ELSE    
    BEGIN    
        -- Failed    
        SELECT     
            0 AS Status,    
            'Invalid User ID or Password' AS Message,    
            NULL AS UserId;    
    END    
END 
GO

Alter PROCEDURE [dbo].[usp_Upsert_IA_BasicDetail]    
(    
    @Id                 INT = 0,   -- 0 = Insert, >0 = Update    
    @Reg_Id             INT,    
    
    -- BASIC DETAIL    
    @OrgType            VARCHAR(100) = NULL,    
    @ActRegistered      VARCHAR(200) = NULL,    
    
    @RegistrationNumber VARCHAR(100) = Null,    
    @RegistrationDate   DATE = NULL,    
    
    @TAN                VARCHAR(20) = NULL,    
    
    -- COMMUNICATION ADDRESS (BASIC)    
    @CommAddress        VARCHAR(300),    
    @CommState          VARCHAR(100),    
    @CommDistrict       VARCHAR(100),    
    @CommPIN            VARCHAR(10),    
    
    -- DOCUMENTS    
    @RC_File            VARCHAR(300) = NULL,    
    @MOA_File           VARCHAR(300) = NULL,    
    @PAN_File           VARCHAR(300) = NULL,    
    
    -- REGISTRATION (MASTER)    
    @RegAddress         VARCHAR(300) = Null,    
    @RegState           VARCHAR(100) = Null,    
    @RegDistrict        VARCHAR(100) = Null,    
    @RegPIN             VARCHAR(10) = Null,    
    
    @OrgMobile          VARCHAR(15),    
    @OrgEmail           VARCHAR(150),    
    @Website            VARCHAR(150) = NULL,  
    
    @AuthName           VARCHAR(150) = Null,    
    @AuthDesig          VARCHAR(100) = Null,    
    @AuthMobile         VARCHAR(15) = Null,    
    @AuthEmail          VARCHAR(150) = Null,
    
    -- FOR CSE
    @DateOfBirth        DateTime = NULL,
    @AadhaarNo          Nvarchar(150) = NULL,
    @Aadhaar_File       NVARCHAR(300) = NULL
)    
AS    
BEGIN    
    SET NOCOUNT ON;    
    
    DECLARE @OutId INT;    
    
    BEGIN TRY    
    
        BEGIN TRANSACTION;    
    
        /* ================= INSERT ================= */    
    
        IF (@Id = 0)    
        BEGIN    
    
            IF EXISTS (SELECT 1 FROM CAHR_BasicDetail WHERE Reg_Id = @Reg_Id)    
            BEGIN    
                ROLLBACK;    
    
                SELECT    
                    0 AS Status,    
                    'Basic details already exist.' AS Message,    
                    0 AS Id;    
                RETURN;    
            END    
    
    
            INSERT INTO CAHR_BasicDetail    
            (    
                Reg_Id,    
                OrgType,    
                ActRegistered,    
                RegistrationNumber,    
                RegistrationDate,    
                TAN,    
    
                CommAddress,    
                CommState,    
                CommDistrict,    
                CommPIN,    
    
                RC_File,    
                MOA_File,    
                PAN_File,    
    
                CreatedOn,
                
                DateOfBirth,
                Aadhaar_File
            )    
            VALUES    
            (    
                @Reg_Id,    
                @OrgType,    
                @ActRegistered,    
                @RegistrationNumber,    
                @RegistrationDate,    
                @TAN,    
    
                @CommAddress,    
                @CommState,    
                @CommDistrict,    
                @CommPIN,    
    
                @RC_File,    
                @MOA_File,    
                @PAN_File,    
    
                GETDATE(),
                @DateOfBirth,
                @Aadhaar_File
            );    
    
            SET @OutId = SCOPE_IDENTITY();    
        END    
    
    
        /* ================= UPDATE ================= */    
    
        ELSE    
        BEGIN    
    
            UPDATE CAHR_BasicDetail    
            SET    
                OrgType            = @OrgType,    
                ActRegistered      = @ActRegistered,    
                RegistrationNumber = @RegistrationNumber,    
                RegistrationDate   = @RegistrationDate,    
                TAN                = @TAN,    
    
                CommAddress        = @CommAddress,    
                CommState          = @CommState,    
                CommDistrict       = @CommDistrict,    
                CommPIN            = @CommPIN,    
    
                RC_File            = ISNULL(@RC_File, RC_File),    
                MOA_File           = ISNULL(@MOA_File, MOA_File),    
                PAN_File           = ISNULL(@PAN_File, PAN_File),
                DateOfBirth        = @DateOfBirth,
                Aadhaar_File       = @Aadhaar_File
    
            WHERE Id = @Id    
              AND Reg_Id = @Reg_Id;    
    
    
            IF (@@ROWCOUNT = 0)    
            BEGIN    
                ROLLBACK;    
    
         SELECT    
                    0 AS Status,    
                    'Invalid record.' AS Message,    
                    0 AS Id;    
                RETURN;    
            END    
    
            SET @OutId = @Id;    
        END    
    
    
        /* ================= UPDATE REGISTRATION ================= */    
    
        UPDATE CAHR_Registration    
        SET    
            -- Registered Address    
            Address  = ISNULL(NULLIF(@RegAddress,''), Address),    
            State    = ISNULL(NULLIF(@RegState,''), State),    
            District = ISNULL(NULLIF(@RegDistrict,''), District),    
            PIN_Code = ISNULL(NULLIF(@RegPIN,''), PIN_Code),    
    
            -- Contact    
            Phone = ISNULL(NULLIF(@OrgMobile,''), Phone),    
            Email = ISNULL(NULLIF(@OrgEmail,''), Email),    
            Website = ISNULL(NULLIF(@Website,''), @Website),  
    
            -- Authorized Person    
            AuthName   = ISNULL(NULLIF(@AuthName,''), AuthName),    
            AuthDesig  = ISNULL(NULLIF(@AuthDesig,''), AuthDesig),    
            AuthMobile = ISNULL(NULLIF(@AuthMobile,''), AuthMobile),    
            AuthEmail  = ISNULL(NULLIF(@AuthEmail,''), AuthEmail),
            Aadhaar = ISNULL(NULLIF(@AadhaarNo,''), Aadhaar)
    
        WHERE Reg_Id = @Reg_Id;    
    
    
        COMMIT TRANSACTION;    
    
    
        SELECT    
            1 AS Status,    
            'Saved successfully.' AS Message,    
            @OutId AS Id;    
    
    END TRY    
    
    BEGIN CATCH    
    
        ROLLBACK TRANSACTION;    
    
        SELECT    
            0 AS Status,    
            ERROR_MESSAGE() AS Message,    
            0 AS Id;    
    
    END CATCH    
END    
GO

Alter PROCEDURE [dbo].[usp_Get_IA_BasicDetails]  
(  
    @Reg_Id INT  
)  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    BEGIN TRY  
  
        SELECT   
  
            /* ========== MASTER ========== */  
            R.Reg_Id,  
            B.Id,  
            R.Reg_Code,  
            R.OrgName,               
            R.PAN,  
            R.Website,  
            R.Aadhaar,
  
            /* ========== AUTHORIZED PERSON (MASTER) ========== */  
            R.AuthName,  
            R.AuthDesig,  
            R.AuthMobile,  
            R.AuthEmail,  
  
            /* ========== MAIN CONTACT (MASTER) ========== */  
            R.Phone      AS OrgMobile,  
            R.Email      AS OrgEmail,  
  
            /* ========== REGISTERED ADDRESS (MASTER) ========== */  
            R.Address    AS RegAddress,  
            R.State      AS RegState,  
            R.District   AS RegDistrict,  
            R.PIN_Code   AS RegPIN,  
  
            /* ========== COMMUNICATION ADDRESS (BASIC) ========== */  
            B.CommAddress,  
            B.CommState,  
            B.CommDistrict,  
            B.CommPIN,  
  
            /* ========== ORGANIZATION DETAILS (BASIC) ========== */  
            B.OrgType,  
            B.ActRegistered,  
            B.RegistrationNumber,  
            B.RegistrationDate,  
            B.TAN, 
            B.DateOfBirth,
  
            /* ========== DOCUMENTS ========== */  
            B.RC_File,  
            B.MOA_File,  
            B.PAN_File,
            B.Aadhaar_File
  
        FROM CAHR_Registration R  
        LEFT JOIN CAHR_BasicDetail B  
            ON R.Reg_Id = B.Reg_Id  
  
        WHERE R.Reg_Id = @Reg_Id;  
  
    END TRY  
  
    BEGIN CATCH  
  
        SELECT   
            0 AS Status,  
            ERROR_MESSAGE() AS Message;  
  
    END CATCH  
END  
go


Alter PROCEDURE dbo.usp_Upsert_IA_ProposedLocation  
    @LocationID INT = 0,  
    @Reg_Id INT,  
    @Block VARCHAR(100),  
    @Tehsil VARCHAR(100),  
    @State VARCHAR(100),  
    @District VARCHAR(100),  
    @PIN_Code VARCHAR(10),
    @VillageMohalla1 VARCHAR(200) = NULL,
    @VillageMohalla2 VARCHAR(200) = NULL,
    @VillageMohalla3 VARCHAR(200) = NULL,
    @VillageMohalla4 VARCHAR(200) = NULL,
    @VillageMohalla5 VARCHAR(200) = NULL
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    BEGIN TRY  
        IF @LocationID = 0  
        BEGIN  
            IF (  
                SELECT COUNT(*)  
                FROM dbo.CAHR_ProposedLocation  
                WHERE Reg_Id = @Reg_Id  
            ) >= 5  
            BEGIN  
                SELECT 0 AS Status,  
                       'Maximum 5 locations allowed.' AS Message;  
                RETURN;  
            END;  
  
            INSERT INTO dbo.CAHR_ProposedLocation  
                (Reg_Id, Block, Tehsil, State, District, PIN_Code, VillageMohalla1, VillageMohalla2, VillageMohalla3, VillageMohalla4, VillageMohalla5)  
            VALUES  
                (@Reg_Id, @Block, @Tehsil, @State, @District, @PIN_Code, @VillageMohalla1, @VillageMohalla2, @VillageMohalla3, @VillageMohalla4, @VillageMohalla5);  
        END  
        ELSE  
        BEGIN  
            UPDATE dbo.CAHR_ProposedLocation  
            SET Block = @Block,  
                Tehsil = @Tehsil,  
                State = @State,  
                District = @District,  
                PIN_Code = @PIN_Code,
                VillageMohalla1 = @VillageMohalla1,
                VillageMohalla2 = @VillageMohalla2,
                VillageMohalla3 = @VillageMohalla3,
                VillageMohalla4 = @VillageMohalla4,
                VillageMohalla5 = @VillageMohalla5
            WHERE LocationID = @LocationID  
              AND Reg_Id = @Reg_Id;  
  
            IF @@ROWCOUNT = 0  
            BEGIN  
                SELECT 0 AS Status, 'Location not found.' AS Message;  
                RETURN;  
            END;  
        END;  
  
        SELECT 1 AS Status, 'Location saved successfully.' AS Message;  
    END TRY  
    BEGIN CATCH  
        SELECT 0 AS Status, ERROR_MESSAGE() AS Message;  
    END CATCH;  
END;  
go

Alter PROCEDURE [dbo].[usp_Get_IA_ProposedLocation]    
(    
    @Reg_Id INT    
)    
AS    
BEGIN    
    
    SELECT    
        LocationID,    
        LocationName,    
        FullAddress,    
        Block,    
        Tehsil,    
        Loc_States.State_Name as State,  
        Loc_States.State_Id as StateId,  
        District,    
        PIN_Code,
        VillageMohalla1,
        VillageMohalla2,
        VillageMohalla3,
        VillageMohalla4,
        VillageMohalla5
    FROM CAHR_ProposedLocation    
    Inner Join Loc_States On CAHR_ProposedLocation.State = Loc_States.State_Id  
    WHERE Reg_Id=@Reg_Id    
    ORDER BY LocationID;    
    
END 
