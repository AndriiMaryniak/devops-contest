

Створення інфраструктури в AWS за допомогою Terraform

Створено кастомну VPC, публічну та приватну підмережі, а також налаштовано Security Groups

- `main.tf` - Головна конфігурація (VPC, Subnets, SG, EC2, Data Sources)
- `variables.tf` - Змінні проєкту
- `outputs.tf` - Вивід IP-адрес
- `init_ubuntu.sh` - Bash скрипт для налаштування Nginx та Docker на Ubuntu
- `init_centos.sh` - Bash скрипт для налаштування Nginx на внутрішньому CentOS
- `terraform_plan_output.txt` - Вивід команди terraform plan

1. Динамічний пошук AMI: Реалізовано через блоки `data "aws_ami"`. Використовуються офіційні owners для Ubuntu та RHEL-based систем
2. Мережева ізоляція (Security Groups): У файлі `main.tf` для Security Group інстансу CentOS (правила Ingress та Egress)
замість діапазонів IP-адрес вказано ID Security Group інстансу Ubuntu (`security_groups = [aws_security_group.ubuntu_sg.id]`)
Це гарантує, що CentOS може спілкуватися ТІЛЬКИ з цією конкретною машиною
3. Налаштування CentOS: Реалізовано через скрипт `init_centos.sh`, який передається через `user_data` та автоматично піднімає веб-сервер
