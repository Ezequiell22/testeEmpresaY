### VIEW

create view task_infos as

SELECT 
    A.allqtd,
    B.avgpriority,
    C.qtddone
FROM 
    (SELECT COUNT(id) allqtd FROM task) AS A
CROSS JOIN 
    (SELECT AVG(priority + 1) AS avgpriority 
	FROM task WHERE status <> 0) AS B
CROSS JOIN 
    (SELECT COUNT(id) AS qtddone 
     FROM task 
     WHERE status = 1 
	 AND date >= (GETDATE() - 7)) AS C;

### table 

CREATE TABLE [dbo].[task](
	[id] [int] NULL,
	[description] [varchar](100) NULL,
	[status] [int] NULL,
	[priority] [int] NULL,
	[DATE] [datetime] NULL
)

### database

o nome do banco utilizado é "teste"

### boss

executar comando 
 -> pasta vcl
- boss install
 -> pasta service
- boss install