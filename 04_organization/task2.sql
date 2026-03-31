-- ============================================
-- Задача 2 (4 балла)
-- Найти подчиненных Ивана Иванова с количеством подчиненных и задач
-- ============================================

WITH RECURSIVE EmployeeHierarchy AS (
    -- Базовый уровень: сам Иван Иванов
    SELECT 
        EmployeeID,
        Name,
        ManagerID,
        DepartmentID,
        RoleID
    FROM Employees
    WHERE EmployeeID = 1
    
    UNION ALL
    
    -- Рекурсивный уровень: подчиненные
    SELECT 
        e.EmployeeID,
        e.Name,
        e.ManagerID,
        e.DepartmentID,
        e.RoleID
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
),
SubordinateCount AS (
    -- Подсчет количества прямых подчиненных
    SELECT 
        ManagerID,
        COUNT(*) AS total_subordinates
    FROM Employees
    WHERE ManagerID IS NOT NULL
    GROUP BY ManagerID
)
SELECT 
    eh.EmployeeID,
    eh.Name AS EmployeeName,
    eh.ManagerID,
    d.DepartmentName,
    r.RoleName,
    GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ') AS ProjectNames,
    GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskName SEPARATOR ', ') AS TaskNames,
    COUNT(DISTINCT t.TaskID) AS TotalTasks,
    COALESCE(sc.total_subordinates, 0) AS TotalSubordinates
FROM EmployeeHierarchy eh
LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
LEFT JOIN Roles r ON eh.RoleID = r.RoleID
LEFT JOIN Tasks t ON eh.EmployeeID = t.AssignedTo
LEFT JOIN Projects p ON t.ProjectID = p.ProjectID
LEFT JOIN SubordinateCount sc ON eh.EmployeeID = sc.ManagerID
GROUP BY eh.EmployeeID, eh.Name, eh.ManagerID, d.DepartmentName, r.RoleName, sc.total_subordinates
ORDER BY eh.Name;
