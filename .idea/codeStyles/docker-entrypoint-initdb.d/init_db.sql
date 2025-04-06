-- Создание базы данных
CREATE DATABASE my_database;

-- Создание пользователя
CREATE USER my_user WITH PASSWORD 'my_secure_password';

-- Привилегии пользователя
GRANT ALL PRIVILEGES ON DATABASE my_database TO my_user;

-- Переключение на новую базу данных
\c my_database

-- Таблица пользователей
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    role TEXT CHECK(role IN ('admin', 'user')) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT NOW()
);

-- Добавление тестового пользователя
INSERT INTO users(username, password_hash, email, role) VALUES('test_user', crypt('password', gen_salt('bf')), 'test@example.com', 'user');