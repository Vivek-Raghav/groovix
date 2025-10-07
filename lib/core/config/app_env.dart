// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  // FastAPI configuration will go here
  final apiBaseUrl = dotenv.env['API_BASE_URL'] ?? '';
}
