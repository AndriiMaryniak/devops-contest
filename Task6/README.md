[![Build Status](http://18.208.177.151:8080/job/GitHub-Build-Pipeline/badge/icon)](http://18.208.177.151:8080/job/GitHub-Build-Pipeline/)


1 Створено нове завдання типу Freestyle project
2 У розділі Source Code Management підключено цей GitHub репозиторій.
3 У розділі Build Steps додано крок Execute shell, де прописані базові команди (echo "Hello World", date, docker ps)
4 Налаштовано збереження історії збірок

Pipeline (Jenkinsfile)
Декларативний пайплайн зберігається у файлі Task6/Jenkinsfile 
Він виконує збірку Dockerfile на Docker-агенті
Безпека: Секретна змінна (пароль QWERTY!) передається безпечно через Jenkins Credentials і прихована в логах

Виконані EXTRA-завдання 
Pipeline на додатковій VM: Створено Jenkins-агента (docker-agent-1), який запускається на вузлі з прокинутим docker.sock для збірки іміджів (Docker-out-of-Docker)
Ansible playbook: Створено плейбук для автоматичного розгортання Jenkins (знаходиться у Task6/deploy_jenkins.yml)
Локальний Docker Registry: Створено скрипт розгортання registry, push/pull операцій та запуску контейнера (знаходиться у Scripts/docker_registry.sh)
Автоматичний запуск (Webhook): Налаштовано GitHub Webhook
Проєкт запускається автоматично після push у гілку main
Статус у Git: Badge зі статусом останньої збірки успішно інтегровано на початку цього README.md
