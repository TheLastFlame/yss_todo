<a href="https://ysstodo.pages.dev">
  <p align="center">
    <picture>
      <img alt="YSS ToDo" src="https://i.ibb.co/RjKTd6d/yss-Banner.png">
    </picture>
  </p>
</a>

# YSS ToDo

Простое ToDo приложение, создаваемое в рамках летней школы Яндекса.

## Features

* Начальная работа с сервером:
   * Реализованы функции добавления, изменения, удаления тасков.
   * Реализована функция загрузки тасков при запуске приложения
   * Индикация факта загрузки с сервера
   * Обработка ошибок на очень зачаточном уровне, фактически -- отсутствует(будет доработана по условиям дз-3)
   * Мерджа данных с локальной бд так же нет (дз-3)

* Сохранение данных в локальном хранилище для офлайн работы
* Локализация Russian/English с поддержкой Android 12+ переключения языков для конкретного приложения.
   <details> 

   <summary>Подробнее:</summary>


   <img src="https://github.com/TheLastFlame/yss_todo/assets/131446187/21c66de6-65f2-42f9-ab87-4f41e99c6483" width="200" /> <img src="https://github.com/TheLastFlame/yss_todo/assets/131446187/0cce6f17-b0d8-4243-be9f-ecb221762607" width="200" /> <img src="https://github.com/TheLastFlame/yss_todo/assets/131446187/df795503-928e-47d9-8dd3-d6eb4c2c642c" width="200" />
   </details>


* Тёмная/Светлая тема.
   <details>
     <summary>Превью:</summary>
 
     Dark                       |  Light
     :-------------------------:|:-------------------------:
     ![](https://github.com/TheLastFlame/yss_todo/assets/131446187/1f8cce3b-0535-44e3-9fe0-afbef05cc569)  |  ![](https://github.com/TheLastFlame/yss_todo/assets/131446187/9f73eb15-1bcb-4ebb-8b84-a241a139b022)
 
    </details>


* Анимированный заголовок, скрывающий часть элементов при прокрутке.
* Анимированное добавление и удаление ивентов.

## Demo

<s>https://ysstodo.pages.dev — web версия</s> [временно неактуально]

## Download
Вы можете найти последнюю версию для Android на странице [Github Releases](https://github.com/TheLastFlame/yss_todo/releases).


Расшифровка версий:
 * app-arm64-v8a-release.apk — 64-битный релиз для всех современных устройств
 * app-arm-v7a-release.apk — 32-битный релиз для очень старых устройств, не поддерживающих релиз выше
 * app-x86_64-release.apk — релиз для экотических андроид устройств не с arm процессорами (amd/intel)

## Build
Для самостоятельной сборки необходимо указать переменные host и token с помощью Dart define

Пример команды: <code>flutter build apk --split-per-abi --dart-define TOKEN=your_token --dart-define HOST=https://google.com</code>



