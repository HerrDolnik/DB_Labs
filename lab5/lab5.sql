-- Нормалізована до 3NF схема
-- Створення таблиць
-- Таблиця користувачів
CREATE TABLE Users (
	UserID SERIAL PRIMARY KEY,
	Username VARCHAR(50) NOT NULL UNIQUE,
	Email VARCHAR(100) NOT NULL UNIQUE,
	RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	IsAdmin BOOLEAN DEFAULT FALSE
);
-- Таблиця категорій
CREATE TABLE Categories (
	CategoryID SERIAL PRIMARY KEY,
	Name VARCHAR(255) NOT NULL UNIQUE,
	Description TEXT
);
-- Таблиця статей
CREATE TABLE Articles (
	ArticleID SERIAL PRIMARY KEY,
	Title VARCHAR(255) NOT NULL,
	Content TEXT NOT NULL,
	CreationTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	UpdateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	UserID INTEGER NOT NULL,
	FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
-- Реалізація співвідношення Many-to-many у Articles-Categories
CREATE TABLE ArticleCategory (
	ArticleID INTEGER NOT NULL,
	CategoryID INTEGER NOT NULL,
	PRIMARY KEY (ArticleID, CategoryID),
	FOREIGN KEY (ArticleID) REFERENCES Articles(ArticleID) ON DELETE CASCADE,
	FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE CASCADE
);
-- Створення таблиці коментарів
CREATE TABLE Comments (
    CommentID SERIAL PRIMARY KEY,
    CommentText TEXT NOT NULL,
    UserID INTEGER NOT NULL,
    ArticleID INTEGER NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ArticleID) REFERENCES Articles(ArticleID) ON DELETE CASCADE
);
-- Створення таблиці історії правок
CREATE TABLE Revisions (
    RevisionID SERIAL PRIMARY KEY,
    EditSummary VARCHAR(255),
    PreEditContent TEXT NOT NULL,
    EditorID INTEGER, -- Може бути NULL, якщо користувач видалений
    ArticleID INTEGER NOT NULL,
    EditTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (EditorID) REFERENCES Users(UserID) ON DELETE SET NULL,
    FOREIGN KEY (ArticleID) REFERENCES Articles(ArticleID) ON DELETE CASCADE
);
-- Наповнення даними
-- Наповнення користувачами
INSERT INTO Users (Username, Email, IsAdmin) VALUES
('HerrDolnik', 'herrdolnik@gmail.com', TRUE),
('Temonchik', 'temonchik33@ukr.net', FALSE),
('Inter360', 'andrew.klym@gmail.com', FALSE);
-- Наповнення категоріями
INSERT INTO Categories (Name, Description) VALUES
('Відеоігри', 'Статті про комп"ютерні ігри'),
('Програмне забезпечення', 'Статті про комп"ютерні програми різних видів'),
('Технології', 'Статті на тему технологічних іновацій в різних научних областях');
-- Наповнення статями
INSERT INTO Articles (Title, Content, UserID) VALUES
('C++', 'C++ - це високорівнева мова програмування...', 2),
('SILENT HILL 2', 'SILENT HILL 2 - це відеогра жанру горор, випущена у 2001 році...', 1),
('TrajectaAPI', 'TrajectaAPI - це програмне забезпечення, що відстежує телеметрію БПЛА...', 3);
-- Зв'язання статей та категорій
INSERT INTO ArticleCategory (ArticleID, CategoryID) VALUES
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(3, 2),
(3, 3);
-- Додаємо тестові коментарі
INSERT INTO Comments (CommentText, UserID, ArticleID) VALUES
('Крутезна стаття! Про символізм Пірамідоголового прям взагалі класно розказано.', 2, 2),
('Абсолютна класика психологічного горору', 3, 2),
('дякую за інформацію, цікаво знати', 3, 1);
-- Додаємо тестові правки
INSERT INTO Revisions (EditSummary, PreEditContent, EditorID, ArticleID) VALUES
('Виправлено орфографічну помилку в назві гри', 'SILENT HIL 2 - це відеогра...', 1, 2),
('Додано інформацію про рушій гри', 'SILENT HILL 2 - це відеогра жанру горор, випущена у 2001 році...', 1, 2),
('Розширено вступ про стандарти мови', 'C++ - це високорівнева мова програмування...', 2, 1);

