# CSI Assignment 5: Open Elective Subject Allotment Tracker

## 📌 Problem Statement

A college wants to maintain a complete timeline of students’ Open Elective subject choices. Students often change their subjects, and the college wants to retain every change, while clearly marking the currently active subject.

### ✅ Requirements:
- Track all subject changes per student.
- Maintain one **active subject** (`Is_Valid = 1`) and others as **inactive** (`Is_Valid = 0`).
- Handle new student entries directly.
- When a subject change is requested, update the old record to inactive and insert the new one as active.

---

## 🧱 Database Schema

### 1. **SubjectAllotments**
| Column Name | Data Type | Description                         |
|-------------|-----------|-------------------------------------|
| StudentId   | `VARCHAR` | Unique identifier for each student |
| SubjectId   | `VARCHAR` | Subject code                       |
| Is_Valid    | `BIT`     | 1 → active, 0 → previously assigned |

### 2. **SubjectRequest**
| Column Name | Data Type | Description                          |
|-------------|-----------|--------------------------------------|
| StudentId   | `VARCHAR` | Student requesting subject change    |
| SubjectId   | `VARCHAR` | New subject requested                |

---

## 🧪 Sample Data Inserted

### SubjectAllotments (Before Execution)
```sql
INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_Valid) VALUES
('159103036', 'PO1491', 1),
('159103036', 'PO1492', 0),
('159103036', 'PO1493', 0),
('159103036', 'PO1494', 0),
('159103036', 'PO1495', 0),
('159103037', 'PO1501', 1);
```

### SubjectRequest (Before Execution)
```sql
INSERT INTO SubjectRequest (StudentId, SubjectId) VALUES
('159103036', 'PO1496'),
('159103038', 'PO1502');
```

### Additional Testing Data
```sql
INSERT INTO SubjectRequest VALUES
('159103037', 'PO1503'),
('159103039', 'PO1600');
```

---

## ⚙️ Stored Procedure Logic

The stored procedure `sp_ProcessSubjectRequests` processes subject change requests from the `SubjectRequest` table using the following logic:

1. **If student already exists** in `SubjectAllotments`:
   - If the requested subject is **different from the active one**, update the current record to `Is_Valid = 0` and insert the new one with `Is_Valid = 1`.
   - If the requested subject is **same as current**, do nothing.

2. **If student doesn't exist** in `SubjectAllotments`:
   - Insert the new subject as `Is_Valid = 1`.

3. **After processing**, the `SubjectRequest` table is cleared.

---

## 📂 Folder Structure

```
CSI-Assignment5/
│
├── README.md                             # Full documentation
│
├── Queries/                              # SQL Scripts used for table creation and logic
│   ├── 01_SubjectAllotments_Table_Creation.sql
│   ├── 02_SubjectAllotments_Data_Input.sql
│   ├── 03_SubjectRequest_Table_Creation.sql
│   ├── 04_SubjectRequest_Data_Input.sql
│   ├── 05_Stored_Procedure_ProcessSubjectRequests.sql
│   ├── 06_Procedure_Execution_and_Final_Data_Verification.sql
│   ├── 07_Sample_Data_Testing.sql
│
├── Outputs/                              # Output Results of SQL execution
│   ├── 01_SubjectAllotments_Table_Creation.rpt
│   ├── 02_SubjectAllotments_Data_Input.xlsx
│   ├── 03_SubjectRequest_Table_Creation.rpt
│   ├── 04_SubjectRequest_Data_Input.xlsx
│   ├── 05_Stored_Procedure_ProcessSubjectRequests.rpt
│   ├── 06_Procedure_Execution_and_Final_Data_Verification.xlsx
│   ├── 07_Sample_Data_Testing_Output.xlsx

```

---

## 📌 Execution Steps

1. **Create tables** from `Create_Tables.sql`
2. **Insert sample data** from `Insert_Sample_Data.sql`
3. **Create stored procedure** from `Stored_Procedure.sql`
4. **Run procedure** using `Execute_Procedure.sql`
5. **Verify output** from `After_Procedure_Execution.sql`
6. **Insert and test with additional data** from `Test_Data.sql`

---

## ✅ Output Verification

Final data can be verified with:
```sql
SELECT * FROM SubjectAllotments ORDER BY StudentId, Is_Valid DESC;
```

---

## 👨‍💻 Author

- **Name**: Aniruddha Sarkar  
- **College**: Techno Main Salt Lake  
- **Department**: Computer Science - Cyber Security  
- **Assignment**: CSI Weekly Assignment 5  

---
