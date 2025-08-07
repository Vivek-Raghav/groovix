import 'package:groovix/features/auth/auth_index.dart';
import 'package:groovix/features/auth/domain/usecase/logout_uc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.loginUc,
    required this.logoutUc,
    required this.signupUc,
  }) : super(AuthInitial()) {
    on<AuthLoginEvent>(_hanldleLogin);
    on<AuthLogoutEvent>(_handleLogout);
    on<AuthSignupEvent>(_handleSignup);
  }

  final LoginUc loginUc;
  final LogoutUc logoutUc;
  final SignupUc signupUc;

  Future<void> _hanldleLogin(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoading());
    final result = await loginUc.call(event.params);
    result.fold((failure) => emit(AuthLoginFailure(error: failure.toString())),
        (success) => emit(AuthLoginSuccess()));
  }

  Future<void> _handleLogout(
      AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLogoutLoading());
    final result = await logoutUc.call(NoParams());
    result.fold((failure) => emit(AuthLogoutFailure(error: failure.toString())),
        (success) => emit(AuthLogoutSuccess()));
  }

  Future<void> _handleSignup(
      AuthSignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthSignupLoading());
    final result = await signupUc.call(event.params);
    result.fold((failure) => emit(AuthSignupFailure(error: failure.toString())),
        (success) => emit(AuthSignupSuccess()));
  }
}
