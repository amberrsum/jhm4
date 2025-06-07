DROP DATABASE IF EXISTS jhm4_test; -- 如果存在則刪除資料庫
CREATE DATABASE jhm4_test; -- 建立資料庫
USE jhm4_test; -- 使用該資料庫

-- 首先創建班級表，因為學生表會引用它
CREATE TABLE Class ( -- 創建班級表
    class_id INT PRIMARY KEY, -- 班級編號（主鍵）
    class_name VARCHAR(50) NOT NULL, -- 班級名稱（不可為空）
    grade INT NOT NULL -- 年級（不可為空）
);

CREATE TABLE Student ( -- 創建學生表
    student_id INT PRIMARY KEY, -- 學生編號（主鍵）
    name VARCHAR(50) NOT NULL, -- 學生姓名（不可為空）
    gender VARCHAR(10), -- 性別
    birthday DATE, -- 出生日期
    class_id INT, -- 班級編號（外鍵）
    FOREIGN KEY (class_id) REFERENCES Class(class_id) -- 外鍵參照班級表的班級編號
);

CREATE TABLE Teacher ( -- 創建教師表
    teacher_id INT PRIMARY KEY, -- 教師編號（主鍵）
    name VARCHAR(50) NOT NULL, -- 教師姓名（不可為空）
    gender VARCHAR(10), -- 性別
    department VARCHAR(50) -- 所屬部門
);

CREATE TABLE Course ( -- 創建課程表
    course_id INT PRIMARY KEY, -- 課程編號（主鍵）
    course_name VARCHAR(100) NOT NULL, -- 課程名稱（不可為空）
    credit INT, -- 學分數
    department VARCHAR(50), -- 所屬部門
    teacher_id INT, -- 授課教師編號（外鍵）
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id) -- 外鍵參照教師表的教師編號
);

-- 學生與課程的多對多關係（選課）
CREATE TABLE Student_Course ( -- 創建學生選課關聯表
    student_id INT, -- 學生編號
    course_id INT, -- 課程編號
    enrollment_date DATE DEFAULT (CURRENT_DATE), -- 選課日期，預設為當前日期
    PRIMARY KEY (student_id, course_id), -- 複合主鍵
    FOREIGN KEY (student_id) REFERENCES Student(student_id), -- 外鍵參照學生表的學生編號
    FOREIGN KEY (course_id) REFERENCES Course(course_id) -- 外鍵參照課程表的課程編號
);

-- 班級與教師的多對多關係（班導師）
CREATE TABLE Class_Teacher ( -- 創建班級導師關聯表
    class_id INT, -- 班級編號
    teacher_id INT, -- 教師編號
    PRIMARY KEY (class_id, teacher_id), -- 複合主鍵
    FOREIGN KEY (class_id) REFERENCES Class(class_id), -- 外鍵參照班級表的班級編號
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id) -- 外鍵參照教師表的教師編號
);

-- 指定使用資料庫
USE jhm4_test;

-- 班級資料插入
INSERT INTO Class (class_id, class_name, grade) VALUES 
    (1, '4A', 4), 
    (2, '4B', 4),
    (3, '5A', 5),
    (4, '5B', 5),
    (5, '3C', 3);

-- 學生資料插入
INSERT INTO Student (student_id, name, gender, birthday, class_id) VALUES 
    (1, '陳大文', 'M', '2006-02-15', 1),
    (2, '李小明', 'M', '2005-11-23', 2),
    (3, '王美麗', 'F', '2006-05-30', 1),
    (4, '張小康', 'M', '2006-07-12', 3),
    (5, '林雅婷', 'F', '2006-03-25', 3),
    (6, '黃建國', 'M', '2006-09-18', 4),
    (7, '周美玲', 'F', '2006-01-05', 4),
    (8, '劉俊宇', 'M', '2008-04-30', 5),
    (9, '楊雅芳', 'F', '2008-08-22', 5),
    (10, '吳志豪', 'M', '2005-10-15', 2);

-- 教師資料插入
INSERT INTO Teacher (teacher_id, name, gender, department) VALUES 
    (1, '張志明', 'M', '數學系'),
    (2, '林美華', 'F', '自然科學系'),
    (3, '李國強', 'M', '語言系'),
    (4, '王建中', 'M', '歷史系'),
    (5, '陳玉華', 'F', '藝術系'),
    (6, '黃明志', 'M', '體育系'),
    (7, '劉小娟', 'F', '資訊系');

-- 課程資料插入
INSERT INTO Course (course_id, course_name, credit, department, teacher_id) VALUES 
    (101, '數學', 4, '數學系', 1),
    (102, '物理', 3, '自然科學系', 2),
    (103, '英文', 3, '語言系', 3),
    (104, '歷史', 3, '歷史系', 4),
    (105, '美術', 2, '藝術系', 5),
    (106, '體育', 2, '體育系', 6),
    (107, '電腦科學', 4, '資訊系', 7),
    (108, '高等數學', 4, '數學系', 1);

-- 學生選課關係插入
INSERT INTO Student_Course (student_id, course_id) VALUES 
    -- 學生1的選課
    (1, 101),
    (1, 102),
    (1, 104),
    -- 學生2的選課
    (2, 101),
    (2, 103),
    (2, 105),
    -- 學生3的選課
    (3, 102),
    (3, 103),
    (3, 108),
    -- 學生4的選課
    (4, 103),
    (4, 104),
    -- 學生5的選課
    (5, 104),
    (5, 105),
    -- 學生6的選課
    (6, 101),
    (6, 106),
    -- 學生7的選課
    (7, 106),
    (7, 107),
    -- 學生8的選課
    (8, 105),
    -- 學生9的選課
    (9, 107),
    -- 學生10的選課
    (10, 108);

-- 班級導師關係插入
INSERT INTO Class_Teacher (class_id, teacher_id) VALUES 
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 7),
    (3, 4),
    (4, 5),
    (5, 6);

------------------------------------------------------------------------------

-- JHM4 資料庫 SELECT 語句練習題
USE jhm4_test;
-- 基礎查詢 (Basic Queries)
-- =====================================================

-- 1. 簡單查詢：查詢所有學生的姓名和性別
-- 你的答案：
SELECT name, gender FROM Student;


-- 2. 條件查詢：查詢所有男學生的資料
-- 你的答案：
SELECT * FROM `Student`
WHERE gender = 'M'

-- 3. 排序查詢：查詢所有學生的資料，按出生日期由早到晚排序
-- 你的答案：
SELECT * FROM Student
ORDER BY birthday ASC;

-- 4. 限制結果數量：查詢前3名最年輕的學生資料
-- 你的答案：
SELECT * FROM Student ORDER BY birthday DESC
LIMIT 3;


-- 中級查詢 (Intermediate Queries)
-- =====================================================

-- 5. 單表聚合函數：統計總共有多少名學生
-- 你的答案：
SELECT COUNT(*) AS total_student FROM Student;


-- 6. 分組統計：統計每個年級有多少個班級
-- 你的答案：
SELECT grade, COUNT(*) as class_count FROM class GROUP by grade ORDER BY grade


-- 7. 條件統計：統計每個性別的學生人數
-- 你的答案：


-- 8. 範圍查詢：查詢學分數在3到4之間的課程資料
-- 你的答案：


-- 表連接查詢 (JOIN Queries)
-- =====================================================

-- 9. 內連接查詢：查詢所有學生的姓名及其所屬班級名稱
-- 你的答案：
SELECT s.name, c.class_name
FROM Student s, Class c
WHERE s.class_id = c.class_id

SELECT s.name, c.class_name
FROM Student s
    JOIN Class c
    on s.class_id = c.class_id 

-- 10. 多表連接：查詢所有課程的名稱、學分數及授課教師姓名
-- 你的答案：
SELECT * FROM Course co
inner join Teacher t on co.teacher_id =t.teacher_id;


-- 11. 複雜連接查詢：查詢每個學生的姓名、班級名稱及其選修的課程名稱
-- 你的答案：
SELECT *
FROM Student s
INNER JOIN Class c ON s.class_id = c.class_id
INNER JOIN Student_Course sc ON s.student_id = sc.student_id
INNER JOIN Course co ON sc.course_id = co.course_id
ORDER BY s.name, co.course_name;


-- 12. 左連接查詢：查詢所有教師及其負責的班級（包括沒有負責班級的教師）
-- 你的答案：


-- 高級查詢 (Advanced Queries)
-- =====================================================

-- 13. 子查詢：查詢選修課程數量最多的學生姓名
-- 你的答案：


-- 14. 複雜統計查詢：統計每個班級的學生人數和平均年齡（以2024年為基準）
-- 你的答案：


-- 15. 分組過濾：查詢選修課程數量超過2門的學生姓名和選修課程數
-- 你的答案：


-- 16. 存在性查詢：查詢沒有學生選修的課程
-- 你的答案：


-- 17. 複雜條件查詢：查詢同時選修「數學」和「物理」的學生姓名
-- 你的答案：


-- 18. 排名查詢：查詢每個部門教師數量最多的前2個部門
-- 你的答案：


-- 綜合應用題 (Comprehensive Questions)
-- =====================================================

-- 19. 複雜業務查詢：查詢「張志明」老師教授的課程中，每門課程有多少名學生選修，並按選修人數降序排列
-- 你的答案：


-- 20. 多層子查詢：查詢選修了「數學系」所有課程的學生姓名
-- 你的答案：


-- 21. 時間計算查詢：查詢每個年級學生的平均年齡（精確到小數點後兩位，以2024年1月1日為基準）
-- 你的答案：


-- 22. 綜合統計報表：生成一份報表，顯示每個班級的詳細資訊：班級名稱、年級、學生總數、男女學生比例、該班學生選修的課程總數
-- 你的答案：