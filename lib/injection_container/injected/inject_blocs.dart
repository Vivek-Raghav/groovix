// Project imports:
import 'package:groovix/core/services/api_service.dart';
import 'package:groovix/features/auth/bloc/auth_bloc.dart';
import 'package:groovix/injection_container/injection_index.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectBlocs() async {
  getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(
    loginUc: getIt(),
    signupUc: getIt(),
    logoutUc: getIt(),
  ));
  
}
