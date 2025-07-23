import 'package:groovix/core/config/flavor_config.dart';

FlavorConfig flavorDevConfig = FlavorConfig(
  flavor: Flavor.dev,
  baseUrl: "https://api.groovix.com",
);

FlavorConfig flavorLocalConfig = FlavorConfig(
  flavor: Flavor.local,
  baseUrl: "http://localhost:3000",
);

FlavorConfig flavorProdConfig = FlavorConfig(
  flavor: Flavor.prod,
  baseUrl: "https://api.groovix.com",
);

FlavorConfig initFlavorConfig(Flavor flavor) {
  switch (flavor) {
    case Flavor.dev:
      return flavorDevConfig;
    case Flavor.local:
      return flavorLocalConfig;
    case Flavor.prod:
      return flavorProdConfig;
  }
}
