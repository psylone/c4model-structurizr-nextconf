# C4 model в Structurizr

Репозиторий с материалами для [Next Conf](https://nextconf.pro/) 2025.

## Запуск сервисов

Используйте команду:

```
docker compose up
```

Поднимутся 2 контейнера:

- structurizr-lite на порту 8080
- structurizr-onpremises на порту 8081

Для логина в Structurizr on-premises используйте логин и пароль [по умолчанию](https://docs.structurizr.com/onpremises/quickstart#3-open-your-web-browser).

Данные для Structurizr Lite находятся в каталоге [lite](/lite). Данные для Structurizr on-premises находятся в каталоге [onpremises](/onpremises).

## Публикация изменений в Structurizr on-premises

После редактирования файла [lite/workspace.dsl](/lite/workspace.dsl) изменения можно посмотреть сразу в Structurizr Lite. Для публикации изменений в Structurizr on-premises необходимо воспользоваться инструментом [Structurizr CLI](https://docs.structurizr.com/cli/installation) и выполнить команду:

```
structurizr-cli push <params> -workspace lite/workspace.dsl
```

Значение параметров `params` можно получить в Structurizr on-premises на [странице настроек](http://localhost:8081/workspace/1/settings) workspace.

## Документация

- [C4 model](https://c4model.com/)
- [Structurizr DSL](https://docs.structurizr.com/dsl)
- [Structurizr Lite](https://docs.structurizr.com/lite)
- [Structurizr on-premises](https://docs.structurizr.com/onpremises)
