
1. Zabbix (Infrastructure Monitoring)

Розгортання: Docker-контейнери (Zabbix Server + PostgreSQL + Web Interface)

Agentless: Налаштовано моніторинг доступності Google DNS (8.8.8.8) через ICMP Ping

Maintenance: Налаштовано періоди обслуговування для запобігання хибним спрацюванням тригерів під час планових робіт

Extra (Ansible): Створено плейбук install_agents.yml для автоматизації встановлення Zabbix-агентів


2. ELK Stack (Logging)

Logstash (Extra 2.4): Налаштовано кастомний фільтр для парсингу Docker-логів

Поля container_name та image_name автоматично перетворюються на docker_container та docker_image

Docker GELF: Налаштовано відправку логів із контейнерів прямо в Logstash через GELF driver

Kibana: Створено Index Pattern для візуалізації та пошуку по логах

3. Grafana (Visualization)

Інтегровано з Elasticsearch як основним джерелом даних

Створено Dashboard для відстеження інтенсивності логів (Count) у розрізі окремих контейнерів

Incident simulation

Втрата зв'язку: Зупинка zabbix-agent викликала спрацювання тригера (Для вирішення було використано режим Maintenance)

Аномальна активність: Симуляція великої кількості помилок у додатку відобразилась як різкий стрибок на графіку в Grafana, 
що дозволило миттєво знайти проблемний контейнер
