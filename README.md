# Базы данных: комплексное задание

## 📌 Описание проекта

Данный проект представляет собой выполнение комплексного задания по курсу "Базы данных". В рамках работы были решены 13 задач на 4 различных базах данных:

| База данных | Количество задач | Баллы |
|-------------|------------------|-------|
| Транспортные средства | 2 | 6 |
| Автомобильные гонки | 5 | 20 |
| Бронирование отелей | 3 | 12 |
| Структура организации | 3 | 12 |
| **Итого** | **13** | **50** |

## 🛠 Технологии

- **СУБД**: MySQL
- **Среда разработки**: XAMPP / phpMyAdmin
- **Язык**: SQL

## 📁 Структура репозитория
sql-database-assignment/
│
├── README.md # Описание проекта
│
├── 01_vehicles/ # Транспортные средства
│ ├── create_tables.sql
│ ├── insert_data.sql
│ ├── task1.sql
│ └── task2.sql
│
├── 02_racing/ # Автомобильные гонки
│ ├── create_tables.sql
│ ├── insert_data.sql
│ ├── task1.sql
│ ├── task2.sql
│ ├── task3.sql
│ ├── task4.sql
│ └── task5.sql
│
├── 03_hotel/ # Бронирование отелей
│ ├── create_tables.sql
│ ├── insert_data.sql
│ ├── task1.sql
│ ├── task2.sql
│ └── task3.sql
│
└── 04_organization/ # Структура организации
├── create_tables.sql
├── insert_data.sql
├── task1.sql
├── task2.sql
└── task3.sql


## 🚀 Инструкция по запуску

### 1. Установка XAMPP
1. Скачайте XAMPP с [официального сайта](https://www.apachefriends.org/)
2. Установите XAMPP в папку `C:\xampp`
3. Запустите XAMPP Control Panel
4. Включите сервисы **Apache** и **MySQL** (нажмите Start)

### 2. Создание базы данных
1. Откройте браузер и перейдите по адресу: `http://localhost/phpmyadmin`
2. Нажмите **"Создать БД"** (или "New")
3. Введите название базы данных (например, `vehicles_db`)
4. Выберите кодировку `utf8_general_ci`
5. Нажмите **"Создать"**

### 3. Выполнение скриптов
Для каждой базы данных:
1. Выберите созданную базу данных в левой панели
2. Перейдите на вкладку **"SQL"**
3. Скопируйте содержимое файла `create_tables.sql` и нажмите **"Выполнить"**
4. Скопируйте содержимое файла `insert_data.sql` и нажмите **"Выполнить"**
5. Для каждой задачи скопируйте содержимое соответствующего файла и выполните

## 📊 Схемы баз данных

### 1. Транспортные средства (vehicles_db)
Vehicle (maker, model, type)
├── Car (vin, model, engine_capacity, horsepower, price, transmission)
├── Motorcycle (vin, model, engine_capacity, horsepower, price, type)
└── Bicycle (serial_number, model, gear_count, price, type)

### 2. Автомобильные гонки (racing_db)
Classes (class, type, country, numDoors, engineSize, weight)
└── Cars (name, class, year)
└── Results (car, race, position)
└── Races (name, date)

### 3. Бронирование отелей (hotel_db)
Hotel (ID_hotel, name, location)
└── Room (ID_room, ID_hotel, room_type, price, capacity)
└── Booking (ID_booking, ID_room, ID_customer, check_in_date, check_out_date)
└── Customer (ID_customer, name, email, phone)

### 4. Структура организации (organization_db)
Departments (DepartmentID, DepartmentName)
Roles (RoleID, RoleName)
└── Employees (EmployeeID, Name, Position, ManagerID, DepartmentID, RoleID)
├── Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
└── Tasks (TaskID, TaskName, AssignedTo, ProjectID)
