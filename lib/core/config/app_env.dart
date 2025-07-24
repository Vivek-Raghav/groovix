import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
}
