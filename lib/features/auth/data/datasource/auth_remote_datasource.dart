import 'package:groovix/core/shared/domain/method/methods.dart';
import 'package:groovix/features/auth/auth_index.dart';
import 'package:groovix/features/auth/domain/usecase/signup_uc.dart';

abstract class AuthRemoteDataSource {
  Future<bool> loginViaEmail(LoginParams params);
  Future<bool> signUpViaEmail(SignUpParams params);
  Future<bool> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();
  final LocalCache _cache = getIt<LocalCache>();
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> loginViaEmail(LoginParams params) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: params.email, password: params.password);
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

  @override
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

  @override
  Future<bool> signUpViaEmail(SignUpParams params) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: params.email, password: params.password);
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
}
