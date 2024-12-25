### VIEW

alter view task_infos as

SELECT 
    A.allqtd,
    B.avgpriority,
    C.qtddone
FROM 
    (SELECT COUNT(id) allqtd FROM task) AS A
CROSS JOIN 
    (SELECT AVG(priority + 1) AS avgpriority 
	FROM task WHERE UPPER(status) <> 'PENDENT') AS B
CROSS JOIN 
    (SELECT COUNT(id) AS qtddone 
     FROM task 
     WHERE UPPER(status) = 'DONE' 
	 AND date >= (GETDATE() - 7)) AS C;