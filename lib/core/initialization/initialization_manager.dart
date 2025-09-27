import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:groovix/core/config/app_env.dart';
import 'package:groovix/core/services/firebase_options.dart';
import 'package:groovix/injection_container/injection_initializer.dart';

class InitializationManager {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await injectionInit();
    await dotenv.load();
    final env = AppEnv();
    // FastAPI initialization will go here when needed
  }
}
