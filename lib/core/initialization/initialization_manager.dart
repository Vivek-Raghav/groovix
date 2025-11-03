// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'package:groovix/injection_container/injection_initializer.dart';

class InitializationManager {
  static Future<void> initialize() async {
    await injectionInit();
    await dotenv.load();
  }
}
