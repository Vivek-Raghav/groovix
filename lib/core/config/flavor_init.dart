// Project imports:
// ignore_for_file: avoid_print
import 'package:groovix/core/config/flavor_config.dart';

FlavorConfig flavorDevConfig = FlavorConfig(
  flavor: Flavor.dev,
  baseUrl: "http://127.0.0.1:8000",
);

FlavorConfig flavorLocalConfig = FlavorConfig(
  flavor: Flavor.local,
  baseUrl: "http://127.0.0.1:8000",
);

FlavorConfig flavorProdConfig = FlavorConfig(
  flavor: Flavor.prod,
  baseUrl: "http://127.0.0.1:8000",
);

FlavorConfig initFlavorConfig(Flavor flavor) {
  FlavorConfig config;
  switch (flavor) {
    case Flavor.dev:
      config = flavorDevConfig;
      break;
    case Flavor.local:
      config = flavorLocalConfig;
      break;
    case Flavor.prod:
      config = flavorProdConfig;
      break;
  }
  print('🎯Flavor: ${config.flavor.name} 🌐 Base URL: ${config.baseUrl}');
  return config;
}
