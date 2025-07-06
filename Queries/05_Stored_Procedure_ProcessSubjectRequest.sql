CREATE PROCEDURE sp_ProcessSubjectRequests
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StudentId VARCHAR(50);
    DECLARE @RequestedSubjectId VARCHAR(50);
    DECLARE @CurrentSubjectId VARCHAR(50);

    DECLARE request_cursor CURSOR FOR
    SELECT StudentId, SubjectId FROM SubjectRequest;

    OPEN request_cursor;
    FETCH NEXT FROM request_cursor INTO @StudentId, @RequestedSubjectId;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        
        IF EXISTS (
            SELECT 1
            FROM SubjectAllotments
            WHERE StudentId = @StudentId
        )
        BEGIN
            
            SELECT @CurrentSubjectId = SubjectId
            FROM SubjectAllotments
            WHERE StudentId = @StudentId AND Is_Valid = 1;

            
            IF @CurrentSubjectId <> @RequestedSubjectId
            BEGIN
                
                UPDATE SubjectAllotments
                SET Is_Valid = 0
                WHERE StudentId = @StudentId AND Is_Valid = 1;

                
                INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_Valid)
                VALUES (@StudentId, @RequestedSubjectId, 1);
            END
        END
        ELSE
        BEGIN
            
            INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_Valid)
            VALUES (@StudentId, @RequestedSubjectId, 1);
        END

        FETCH NEXT FROM request_cursor INTO @StudentId, @RequestedSubjectId;
    END

    CLOSE request_cursor;
    DEALLOCATE request_cursor;

    
    DELETE FROM SubjectRequest;
END;
