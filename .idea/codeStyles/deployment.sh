#!/bin/bash

# Настройки для запуска контейнера
IMAGE_NAME="my_project_postgres"
CONTAINER_NAME="my_postgres_container"
DOCKER_REGISTRY="your_docker_registry_url" # Например, registry.gitlab.com/your_group/your_project
PORT_MAPPING="5432:5432"
VOLUME_MOUNT="/path/to/volume:/opt/lib/postgresql/data" # Местоположение данных на хост-машине

# Проверяем и устанавливаем последнее обновление образа
if [[ "$(docker images -q ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest)" != "" ]]; then
    echo "Удаляем старый образ контейнера..."
    docker rmi "${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
fi

echo "Загружаем последний образ..."
docker pull "${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"

# Остановка существующего контейнера (если запущен)
if [[ "$(docker ps -aqf name=${CONTAINER_NAME})" != "" ]]; then
    echo "Остановка старого контейнера..."
    docker stop ${CONTAINER_NAME}
    docker rm ${CONTAINER_NAME}
fi

# Запуск контейнера с новым образом
echo "Запуск нового контейнера..."
docker run -d \
           --restart unless-stopped \
           --name ${CONTAINER_NAME} \
           -p ${PORT_MAPPING} \
           -v ${VOLUME_MOUNT} \
           "${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"

echo "Контейнер успешно запущен!"