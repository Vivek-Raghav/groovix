// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'package:groovix/core/config/app_env.dart';
import 'package:groovix/injection_container/injection_initializer.dart';

class InitializationManager {
  static Future<void> initialize() async {
    await injectionInit();
    await dotenv.load();
    final env = AppEnv();
    // FastAPI initialization will go here when needed
  }
}
