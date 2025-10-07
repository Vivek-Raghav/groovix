// Project imports:
import 'package:groovix/features/auth/bloc/auth_bloc.dart';
import 'package:groovix/features/song/bloc/cubit/song_cubit.dart';
import 'package:groovix/injection_container/injection_index.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectBlocs() async {
  getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(
        loginUc: getIt(),
        signupUc: getIt(),
        logoutUc: getIt(),
      ));
  getIt
      .registerLazySingleton<SongCubit>(() => SongCubit(uploadSongUc: getIt()));
}
