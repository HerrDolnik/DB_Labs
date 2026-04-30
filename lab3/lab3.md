# Лабораторна робота №3: OLTP

## I. SELECT

### 1.1 Показ всіх користувачів
```sql
SELECT * FROM Users;
```
![All users](img/selectusers.jpg)

### 1.2 Показ всіх статей
```sql
SELECT * FROM Articles;
```
![All articles](img/selectarticles.jpg)

### 1.3 Показ всіх категорій
```sql
SELECT * FROM Categories;
```
![All categories](img/selectcategories.jpg)

### 1.4 Показ електронних пошт всіх користувачів без адмінок
```sql
SELECT Email FROM Users
WHERE IsAdmin = FALSE;
```
![All non admin users' emails](img/select_emails.jpg)

### 1.5 Показ статей від користувача з ID 3
```sql
SELECT Title, Content FROM Articles
WHERE UserID = 3;
```
![All articles from user with UserID 3](img/select_userid3.jpg)

### 1.6 Показ категорій, до якиї належить стаття з ID 2
```sql
SELECT Categories.Name FROM Categories
JOIN ArticleCategory ON ArticleCategory.CategoryID = Categories.CategoryID
WHERE ArticleCategory.ArticleID = 2;
```
![All categories from article with ArticleID 2](img/select_categories.jpg)

## II. INSERT

### 2.1 Додавання двох нових користувачів
```sql
INSERT INTO Users (Username, Email, IsAdmin) VALUES
('Genokiller2222', 'sasaakubin@ukr.net', TRUE),
('kanarejkaleblaaack', 'igor.chornyy@gmail.com', FALSE);
SELECT * FROM Users;
```
![Insert new users](img/insert_users.jpg)
![Insert new users2](img/insert_users2.jpg)

### 2.2 Додавання нової статті в таблицю та існуючі категорії
```sql
INSERT INTO Articles (Title, Content, UserID) VALUES
('Hollow Knight: Silksong', 'Hollow Knight: - це комп"ютерна інді гра, що вийшла у 2025 році...', 5);

INSERT INTO ArticleCategory (ArticleID, CategoryID) VALUES
(4, 1), (4, 2);

SELECT Title, Content, UserID FROM Articles;
SELECT * FROM ArticleCategory;
```
![Insert new article](img/insert_silksong.jpg)
![Insert new article2](img/insert_silksong2.jpg)


### 2.3 Додавання нової категорії
```sql
INSERT INTO Categories (Name, Description) VALUES
('Хімія', 'Статті про все, що пов"язано з хімією: науковці, закони і т.д.');

SELECT * FROM Categories;
```
![Insert new category](img/insert_chem.jpg)

## III. UPDATE

### 3.1 Оновлення статті з ID 1
```sql
UPDATE Articles
SET Content = 'C++ фігня, а от Java - ось це вже інша розмова',
UpdateTime = CURRENT_TIMESTAMP
WHERE ArticleID = 1;

SELECT * FROM Articles
WHERE ArticleID = 1;
```
![Update c++ article to java](img/update_java.jpg)

### 3.2 Видача користувачу з ID 3 адмінськиї прав
```sql
UPDATE Users
SET IsAdmin = TRUE
WHERE UserID = 3;

SELECT * FROM Users;
```
![Update userid3 admin](img/update_admin.jpg)

### 3.3 Коректування назви та опису категорії
```sql
UPDATE Categories
SET Name = 'Комп"ютерні ігри', Description = 'Статті про відеоігри'
WHERE CategoryID = 1;

SELECT Name, Description from Categories;
```
![Update games](img/update_games.jpg)

## IV. DELETE

### 4.1.1 Помилка видалення користувача через те, що стаття ще існує
```sql
DELETE FROM Users
WHERE Users.UserID = 2;

SELECT * FROM Users;
```
![Fail](img/delete_failed.jpg)

### 4.2 Видалення статей користувача з ID 2
```sql
DELETE FROM Articles
WHERE UserID = 2;

SELECT * FROM Articles;
```
![userid2 delete artciles](img/delete_articles.jpg)

### 4.1.2 Видалення користувача з ID 2
```sql
DELETE FROM Users
WHERE UserID = 2;

SELECT * FROM Users;
```
![userid2 delete](img/delete_user.jpg)

### 4.3 Видалення категорії "Хімія"
```sql
DELETE FROM Categories
WHERE Name = 'Хімія';

SELECT * FROM Categories;
```
![chemistry category delete](img/delete_chem.jpg)

### 4.4 Видалення статті з ID 2 зі всіх категорій
```sql
DELETE FROM ArticleCategory
WHERE ArticleID = 2;

SELECT * FROM ArticleCategory;
```
![article2 category delete](img/delete_2article.jpg)

## Висновок
На даній лабораторній роботи я виконував OLTP-виклики в базі даних. По ходу її виконання я практикував виклики таблиці та їх окремі елементів, вставлення нових елементів у таблиці, зміни уже існуючих елементів, а також видалення елементів з таблиць. При маніпуляціях з таблицями в базі даних проблем не виникло.