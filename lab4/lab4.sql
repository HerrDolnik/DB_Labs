-- I. Агрегатні функції
-- 1.1 COUNT: Підрахунок всіх статей в енциклопедії
SELECT COUNT(*) AS TotalArticles
FROM Articles;


-- 1.2 MIN/MAX: Визначення дат створення найстарішої та найновішої статей в енциклопедії
SELECT 
MIN(CreationTime) AS OldestArticleCreated,
MAX(CreationTime) AS NewestArticleCreated
FROM Articles;


-- 1.3 GROUP BY: Групування користувачів та кількості статей, які вони написали
SELECT u.Username,
COUNT(a.ArticleID) AS articlecount 
FROM Users u
LEFT JOIN Articles a ON u.UserID = a.UserID
GROUP BY u.Username;


-- 1.4 HAVING: Визначення категорії, в якій більше ніж 1 стаття
SELECT c.Name AS CategoryName,
COUNT(ac.ArticleID) AS ArticleCount
FROM Categories c
JOIN ArticleCategory ac ON c.CategoryID = ac.CategoryID
GROUP BY c.Name
HAVING COUNT(ac.ArticleID) > 1;


-- II. Типи JOIN
-- 2.1.1 INNER JOIN: Виведення кожної статті з іменем її автора, що міститься хоча в одній категорії
SELECT a.Title, u.Username AS Author,
c.Name AS Category
FROM Articles a
INNER JOIN Users u ON a.UserID = u.UserID
INNER JOIN ArticleCategory ac ON a.ArticleID = ac.ArticleID
INNER JOIN Categories c ON ac.CategoryID = c.CategoryID;


-- 2.1.2 LEFT JOIN: Виведення кожної статті з іменем її автора та категорією
SELECT a.Title, u.Username AS Author,
c.Name AS Category
FROM Articles a
INNER JOIN Users u ON a.UserID = u.UserID
LEFT JOIN ArticleCategory ac ON a.ArticleID = ac.ArticleID
LEFT JOIN Categories c ON ac.CategoryID = c.CategoryID;

-- ---Заради наглядності повернемо пусту категорію в таблицю--------
INSERT INTO Categories (Name, Description) VALUES
('Хімія', 'Статті про все, що пов"язано з хімією: науковці, закони і т.д.');

SELECT * FROM Categories;
-- -----------------------------------------------------------------

-- 2.2 RIGHT JOIN: Виведення кожної категорії та кожної прив'язаної до неї статті
SELECT c.Name as CategoryName,
a.Title as ArticleTitle
FROM ArticleCategory ac
INNER JOIN Articles a on ac.ArticleID = a.ArticleID
RIGHT JOIN Categories c on ac.CategoryID = c.CategoryID;


-- III. Підзапити
-- 3.1 Виведення кожної статті, чий автор є адміном, разом з іменем її відповідного автора
SELECT a.Title, u.Username AS Author
FROM Articles a
JOIN Users u ON a.UserID = u.UserID
WHERE a.UserID IN (
	SELECT UserID FROM Users
	WHERE IsAdmin = TRUE
);


-- 3.2 SELECT підзапит: Виведення користувачів та кількості написаних ними статей
SELECT u.Username, u.Email, (
	SELECT COUNT(*) FROM Articles a WHERE a.UserID = u.UserID 
) AS TotalWrittenArticles
FROM Users u;


-- 3.3 WHERE підзапит з агрегацією: Знаходження статті, яка була створенна найостаннішою
SELECT Title, CreationTime FROM Articles
WHERE CreationTime = (SELECT MAX(CreationTime) FROM Articles);
