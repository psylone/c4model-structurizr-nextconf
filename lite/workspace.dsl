workspace "Market Space" "Workspace описывает архитектуру проекта Market Space - сервиса электронной коммерции." {
  !identifiers hierarchical

  model {
    // People

    customer = person Покупатель "Пользователь сервиса\nMarket Space." "Customer"

    group "Market Space" {
      marketplace = softwareSystem Marketplace "Основная система электронной коммерции для взаимодействия с пользователем." {
        androidMobileApp = container "Android Mobile App" "Мобильное приложение\nMarket Space для Android." "Android" "Mobile App"
        iOSMobileApp = container "iOS Mobile App" "Мобильное приложение\nMarket Space для iOS." "iOS" "Mobile App"

        apiGateway = container "API Gateway" "Шлюз API для маршрутизации и аутентификации запросов между клиентами и бэкэнд-сервисами." "Java, Spring Boot" {
          routingComponent = component "Routing Service" "Маршрутизирует входящие запросы к соответствующим backend-сервисам." "Java, Spring Cloud Gateway"
          securityComponent = component "Security Filter" "Обеспечивает аутентификацию и авторизацию входящих запросов." "Java, Spring Security"
          trafficComponent = component "Traffic Manager" "Обеспечивает лимитирование запросов." "Java, Spring Boot"
        }

        productCatalog = container "Product Catalog" "Предоставляет данные о товарах и категориях." "Java, Spring Boot"
        orderManager = container "Order Manager" "Управляет корзиной покупок." "Java, Spring Boot"
        productCatalogDatabase = container "Product Catalog Database" "Хранит информацию о товарах и категориях." "PostgreSQL" Database
        orderManagerDatabase = container "Order Manager Database" "Хранит информацию о корзинах и товарах." "PostgreSQL" Database
      }

      paymentSystem = softwareSystem "Payment System" "Система проведения платежей."
      notificationSystem = softwareSystem "Notification System" "Система уведомления пользователей по SMS и email."
    }

    // External systems

    paymentProcessor = softwareSystem "Payment Processor" "Платежный шлюз." "External System"
    smsProvider = softwareSystem "SMS Provider" "SMS шлюз." "External System"
    emailService = softwareSystem "Email Service" "Сервис для отправки email." "External System"

    // Relationships

    customer -> marketplace.androidMobileApp "Выбирает товары и делает покупки"
    customer -> marketplace.iOSMobileApp "Выбирает товары и делает покупки"
    marketplace -> paymentSystem "Проводит платежи"
    marketplace -> notificationSystem "Отправляет SMS и email пользователю"

    paymentSystem -> paymentProcessor "Проводит платежи через внешний платежный шлюз"
    notificationSystem -> smsProvider "Отправляет SMS через внешнюю систему"
    notificationSystem -> emailService "Отправляет email через внешнюю систему"

    marketplace.androidMobileApp -> marketplace.apiGateway.routingComponent "Выполняет вызовы API" "HTTPS, JSON"
    marketplace.iOSMobileApp -> marketplace.apiGateway.routingComponent "Выполняет вызовы API" "HTTPS, JSON"
    marketplace.apiGateway.routingComponent -> marketplace.apiGateway.securityComponent "Аутентифицирует и авторизует запросы"
    marketplace.apiGateway.routingComponent -> marketplace.apiGateway.trafficComponent "Проверяет допустимый лимит запросов"
    marketplace.apiGateway -> marketplace.productCatalog "Получает данные о товарах и категориях" "HTTPS, JSON"
    marketplace.productCatalog -> marketplace.productCatalogDatabase "Читает и пишет данные" "TCP"
    marketplace.apiGateway -> marketplace.orderManager "Вызывает методы API управления корзиной" "HTTPS, JSON"
    marketplace.orderManager -> marketplace.orderManagerDatabase "Читает и пишет данные" "TCP"
    marketplace.orderManager -> paymentSystem "Проводит платежи" "HTTPS, JSON"
  }

  views {
    systemLandscape MarketSpaceLandscape {
      include *
      autolayout tb
    }

    systemContext marketplace MarketplaceSystemContext "Диаграмма уровня контекста, которая описывает основную систему электронной коммерции." {
      properties {
          structurizr.groups false
      }

      include *
      autolayout tb
    }

    container marketplace MarketplaceContainers "Диаграмма уровня контейнеров, которая описывает основную систему электронной коммерции." {
      include *
      autolayout tb
    }

    component marketplace.apiGateway APIGatewayComponents "Диаграмма уровня компонентов, которая описывает сервис API Gateway." {
      include *
      autolayout tb
    }

    image marketplace.apiGateway.trafficComponent TrafficManagerCode {
      image "images/marketplace-apigateway-trafficmanager-code.png"
      title "[Code] Marketplace - API Gateway - Traffic Manager"
      description "Диаграмма уровня кода, которая описывает компонент Traffic Manager."
    }

    styles {
      element Person {
        shape Person
      }

      element Customer {
        background #4d0463
        color #ffffff
      }

      element "Software System" {
        background #820ea9
        color #ffffff
      }

      element "External System" {
        background #dddddd
        color #000000
      }

      element Container {
        background #9e10ce
        color #ffffff
      }

      element Component {
        background #ae58ca
        color #ffffff
        shape Component
      }

      element "Mobile App" {
        shape MobileDeviceLandscape
      }

      element Database {
        shape Cylinder
      }
    }
  }
}
