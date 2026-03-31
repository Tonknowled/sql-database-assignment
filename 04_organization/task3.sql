-- ============================================
-- Задача 3 (4 балла)
-- Найти менеджеров, у которых есть подчиненные
-- ============================================

WITH RECURSIVE SubordinateHierarchy AS (
    -- Базовый уровень: все сотрудники
    SELECT 
        EmployeeID,
        ManagerID
    FROM Employees
    
    UNION ALL
    
    -- Рекурсивный уровень: подчиненные подчиненных
    SELECT 
        e.EmployeeID,
        sh.ManagerID
    FROM Employees e
    INNER JOIN SubordinateHierarchy sh ON e.ManagerID = sh.EmployeeID
),
AllSubordinates AS (
    -- Считаем общее количество подчиненных для каждого менеджера
    SELECT 
        ManagerID,
        COUNT(DISTINCT EmployeeID) AS total_subordinates
    FROM SubordinateHierarchy
    WHERE ManagerID IS NOT NULL
    GROUP BY ManagerID
)
-- Выводим информацию о менеджерах, у которых есть подчиненные
SELECT 
    e.EmployeeID,
    e.Name AS EmployeeName,
    e.ManagerID,
    d.DepartmentName,
    r.RoleName,
    GROUP_CONCAT(DISTINCT p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ') AS ProjectNames,
    GROUP_CONCAT(DISTINCT t.TaskName ORDER BY t.TaskName SEPARATOR ', ') AS TaskNames,
    COALESCE(ast.total_subordinates, 0) AS TotalSubordinates
FROM Employees e
INNER JOIN AllSubordinates ast ON e.EmployeeID = ast.ManagerID
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN Roles r ON e.RoleID = r.RoleID
LEFT JOIN Tasks t ON e.EmployeeID = t.AssignedTo
LEFT JOIN Projects p ON t.ProjectID = p.ProjectID
GROUP BY e.EmployeeID, e.Name, e.ManagerID, d.DepartmentName, r.RoleName, ast.total_subordinates
ORDER BY e.Name;
