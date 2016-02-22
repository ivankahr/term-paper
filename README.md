# Курсова робота

* `config.json` - налаштування з'єднання з базою даних MySQL
* `server.coffee` - основний файл програми

## Установка

* Node.js
* Встановити сервер баз даних MySQL
* `npm install -g coffee-script gulp bower` - інтерпретатор мови CoffeeScript
* `npm install` - серверні залежності проекту
* `bower install` - клієнтські залежності проекту

## Підготовка БД

* Створити базу даниз з назвою `term-paper`
* `coffee import.coffee` - створення таблиць з тестовими даними

## Запуск

* `gulp` (`gulp dev`) - збирання проекту (в режимі розробки)
* `coffee server.coffee` - старт сервера
