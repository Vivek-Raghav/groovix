// Project imports:
import 'package:groovix/features/cms/songs/domain/usecase/cms_upload_song_uc.dart';
import 'package:groovix/features/cms/songs/domain/usecase/update_song_field_uc.dart';
import 'package:groovix/features/cms/songs/domain/usecase/delete_song_uc.dart';
import 'package:groovix/features/cms/songs/domain/usecase/search_song_uc.dart';
import 'package:groovix/features/song/domain/usecase/get_song_flags_uc.dart';
import 'package:groovix/features/song/domain/usecase/update_song_flags_uc.dart';
import 'package:groovix/injection_container/injection_index.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectUsecases() async {
  getIt.registerLazySingleton<LoginUc>(() => LoginUc(authRepository: getIt()));
  getIt
      .registerLazySingleton<SignupUc>(() => SignupUc(authRepository: getIt()));
  getIt
      .registerLazySingleton<LogoutUc>(() => LogoutUc(authRepository: getIt()));
  getIt.registerLazySingleton<UploadSongUc>(
      () => UploadSongUc(cmsSongRepository: getIt()));
  getIt.registerLazySingleton<SearchSongUc>(
      () => SearchSongUc(cmsSongRepository: getIt()));
  getIt.registerLazySingleton<SongListUc>(
      () => SongListUc(songRepository: getIt()));
  getIt.registerLazySingleton<UpdateSongFieldsUseCase>(
      () => UpdateSongFieldsUseCase(getIt()));
  getIt.registerLazySingleton<DeleteSongUc>(
      () => DeleteSongUc(cmsSongRepository: getIt()));
  getIt.registerFactory<UpdateSongFlagsUc>(
      () => UpdateSongFlagsUc(songRepository: getIt()));
  getIt.registerFactory<GetSongFlagsUc>(
      () => GetSongFlagsUc(songRepository: getIt()));
}
