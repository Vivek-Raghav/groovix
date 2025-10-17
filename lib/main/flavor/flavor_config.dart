// ignore_for_file: unnecessary_null_comparison

enum Flavor {
  local,
  dev,
  prod,
}

class FlavorConfig {
  final Flavor flavor;
  final String baseUrl;

  static late FlavorConfig _instance;
  static bool _isInitialized = false;

  factory FlavorConfig({
    required Flavor flavor,
    required String baseUrl,
  }) {
    _instance = FlavorConfig._internal(flavor, baseUrl);
    _isInitialized = true;
    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.baseUrl);

  static FlavorConfig get instance => _instance;
  static bool get isInitialized => _isInitialized;
}
