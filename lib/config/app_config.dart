enum Environment { dev, staging, prod }

class AppConfig {
  AppConfig._();

  static Environment environment = Environment.dev;

  static String get baseUrl {
    switch (environment) {
      case Environment.dev:
        return 'http://localhost:3000/api';
      case Environment.staging:
        return 'https://staging-api.sportscorepick.com/api';
      case Environment.prod:
        return 'https://api.sportscorepick.com/api';
    }
  }

  static bool get isDev => environment == Environment.dev;
  static bool get isStaging => environment == Environment.staging;
  static bool get isProd => environment == Environment.prod;

  static void setEnvironment(Environment env) {
    environment = env;
  }
}
