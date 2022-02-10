enum FlavorType { dev, prod }

class Flavor {
  Flavor._();

  static FlavorType get environment {
    const flavor = String.fromEnvironment('FLAVOR');
    if (flavor == 'dev') {
      return FlavorType.dev;
    } else if (flavor == 'prod') {
      return FlavorType.prod;
    }
    throw AssertionError('No support flavor');
  }
}
