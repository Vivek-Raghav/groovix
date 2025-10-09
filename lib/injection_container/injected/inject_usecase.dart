// Project imports:
import 'package:groovix/injection_container/injection_index.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectUsecases() async {
  getIt.registerLazySingleton<LoginUc>(() => LoginUc(authRepository: getIt()));
  getIt
      .registerLazySingleton<SignupUc>(() => SignupUc(authRepository: getIt()));
  getIt
      .registerLazySingleton<LogoutUc>(() => LogoutUc(authRepository: getIt()));
  getIt.registerLazySingleton<UploadSongUc>(
      () => UploadSongUc(songRepository: getIt()));
  getIt.registerLazySingleton<SongListUc>(
      () => SongListUc(songRepository: getIt()));
}
