// Project imports:
import 'package:groovix/core/services/music_player/bloc/music_player_bloc.dart';
import 'package:groovix/core/services/music_player/music_player_manager.dart';
import 'package:groovix/features/auth/bloc/auth_bloc.dart';
import 'package:groovix/features/song/bloc/cubit/song_cubit.dart';
import 'package:groovix/injection_container/injection_index.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectBlocs() async {
  getIt.registerLazySingleton<AuthBloc>(
      () => AuthBloc(loginUc: getIt(), signupUc: getIt(), logoutUc: getIt()));
  getIt.registerLazySingleton<SongCubit>(
      () => SongCubit(uploadSongUc: getIt(), songListUc: getIt()));
  getIt.registerLazySingleton<MusicPlayerManager>(() => MusicPlayerManager());
  getIt.registerLazySingleton<MusicPlayerBloc>(() => MusicPlayerBloc(getIt()));
}
