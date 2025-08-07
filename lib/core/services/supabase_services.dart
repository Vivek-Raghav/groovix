import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  Future<void> initialize(
      {required String url, required String anonKey}) async {
    await Supabase.initialize(url: url, anonKey: anonKey);
  }

  final supabaseInt = Supabase.instance.client;

  Future<void> insertUserData(User user) async {
    await supabaseInt.from("users").insert(user.toJson());
  }

  Future<void> updateUserData(User user) async {
    await supabaseInt.from("users").update(user.toJson()).eq('id', user.id);
  }
}
