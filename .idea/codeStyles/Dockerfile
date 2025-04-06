# Используем официальный образ PostgreSQL последней версии
FROM postgres:latest

# Устанавливаем переменные окружения для пользователя и пароля
ENV POSTGRES_USER=my_user
ENV POSTGRES_PASSWORD=my_password
ENV POSTGRES_DB=my_database

# Добавляем init.sql файл в каталог, где PostgreSQL ожидает увидеть сценарии начальной загрузки
COPY docker-entrypoint-initdb.d/* /docker-entrypoint-initdb.d/

# Открываем порт 5432 для внешних подключений
EXPOSE 5432

# Команда запуска PostgreSQL контейнера (автоматически берется из родительского образа)
CMD ["postgres"]