enum FlavorType { dev, prd }

class Flavor {
  Flavor._();

  static FlavorType get environment {
    const flavor = String.fromEnvironment('FLAVOR');
    if (flavor == 'dev') {
      return FlavorType.dev;
    } else if (flavor == 'prd') {
      return FlavorType.prd;
    }
    throw Exception('Not support flavor');
  }
}
