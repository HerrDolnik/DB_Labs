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


