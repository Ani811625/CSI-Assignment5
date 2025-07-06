EXEC sp_ProcessSubjectRequests;

SELECT * FROM SubjectAllotments ORDER BY StudentId, Is_Valid DESC;
