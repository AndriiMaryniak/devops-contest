Мій зібраний образ тут:

https://hub.docker.com/r/takizavvaa/andrii-webapp

1) Файли в репозиторії

install_docker_env.sh — bash-скрипт для автоматичного встановлення Docker на чисту Ubuntu (EXTRA 1.1)

Dockerfile — файл для збірки власного образу з Nginx на базі ubuntu:24.04 (EXTRA 3.1.1)

entrypoint.sh — скрипт, який динамічно створює index.html і підставляє туди змінну DEVOPS перед запуском сервера (EXTRA 3.2.1)
  
.github/workflows/docker-build.yml — налаштування CI/CD. Образ автоматично збирається та відправляється на Docker Hub при нових комітах (EXTRA 4.1)

docker-compose.yml та .env — запуск інфраструктури. Піднімає базу PostgreSQL, Java-додаток (який стартує тільки після того, як БД пройде healthcheck) і дві репліки мого веб-сервера. Паролі винесено в .env файл (EXTRA 5.1)

2) Основні команди

docker run hello-world — перевірка коректності встановлення Docker

docker run -d -p 80:80 --name test-nginx nginx — запуск стандартного образу Nginx

docker exec test-nginx sh -c 'echo "Andrii Maryniak Sandbox 2021" > /usr/share/nginx/html/index.html' — зміна тексту всередині працюючого контейнера (EXTRA 2.1)

docker build -t takizavvaa/andrii-webapp:latest . — збірка образу з Dockerfile

docker push takizavvaa/andrii-webapp:latest — відправка образу в публічний реєстр

docker compose up -d — фоновий запуск бази даних та додатків

docker ps — перевірка статусу контейнерів

docker compose down — зупинка інфраструктури
