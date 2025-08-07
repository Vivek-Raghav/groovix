import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  Future<void> initialize(
      {required String url, required String anonKey}) async {
    await Supabase.initialize(url: url, anonKey: anonKey);
  }
}
