import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:groovix/core/config/app_env.dart';
import 'package:groovix/core/services/firebase_options.dart';
import 'package:groovix/core/services/supabase_services.dart';
import 'package:groovix/injection_container/injection_initializer.dart';

class InitializationManager {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await injectionInit();
    await dotenv.load();
    final env = AppEnv();
    try {
      await SupabaseServices()
          .initialize(url: env.supabaseUrl, anonKey: env.supabaseAnonKey);
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing Supabase: $e');
      }
    }
  }
}
