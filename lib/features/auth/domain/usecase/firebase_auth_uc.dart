import 'package:groovix/core/shared/domain/method/methods.dart';
import 'package:groovix/features/auth/auth_index.dart';
import 'package:groovix/main/main_index.dart';

class FirebaseAuthUc {
  final firebaseAuth = FirebaseAuth.instance;
  final _cache = getIt<LocalCache>();

  Future<bool> loginViaEmail(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final user = firebaseAuth.currentUser;
    try {
      if (user != null) {
        final token = await user.getIdToken();
        await _cache.setString(PrefKeys.token, token ?? "");
        await _cache.setBool(PrefKeys.isLoggedIn, true);
        await _cache.setString(PrefKeys.userEmail, user.email ?? "");
        return true;
      } else {
        throw Exception("User not found");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast(title: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showToast(title: "Wrong password.");
      } else {
        showToast(title: e.code);
      }
      return false;
    } catch (e) {
      debugPrint("Auth Sign Up Error: $e");
      return false;
    }
  }

  Future<bool> signUpViaEmail(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = firebaseAuth.currentUser;
    try {
      if (user != null) {
        await _cache.setBool(PrefKeys.isLoggedIn, true);
        await _cache.setString(PrefKeys.userEmail, user.email ?? "");
        return true;
      } else {
        throw Exception("User not found");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast(title: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showToast(title: "Wrong password.");
      } else {
        showToast(title: e.code);
      }
      return false;
    } catch (e) {
      debugPrint("Auth Sign Up Error: $e");
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await firebaseAuth.signOut();
      await _cache.clearAllStorage();
    } catch (e) {
      debugPrint("Auth Logout Error: $e");
      return false;
    }
    return true;
  }
}
