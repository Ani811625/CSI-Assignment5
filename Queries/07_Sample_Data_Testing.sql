INSERT INTO SubjectRequest VALUES ('159103037', 'PO1503');
INSERT INTO SubjectRequest VALUES ('159103039', 'PO1600');

EXEC sp_ProcessSubjectRequests;

SELECT * FROM SubjectAllotments ORDER BY StudentId, Is_Valid DESC;
