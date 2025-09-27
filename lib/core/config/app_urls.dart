import 'package:groovix/core/config/flavor_config.dart';

class AppUrls {
  static String get baseUrl => FlavorConfig.instance.baseUrl;
  static String get signup => '$baseUrl/signup';
}
