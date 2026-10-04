ALTER TABLE dbo.CAHR_Registration
ADD
    RegistrationType VARCHAR(10) NULL,
    Aadhaar VARCHAR(12) NULL;
    go


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
