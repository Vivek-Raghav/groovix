// Project imports:
import 'package:groovix/features/cms/songs/domain/usecase/cms_upload_song_uc.dart';
import 'package:groovix/features/cms/songs/domain/usecase/delete_song_uc.dart';
import 'package:groovix/features/cms/songs/domain/usecase/search_song_uc.dart';
import 'package:groovix/features/cms/songs/domain/usecase/update_song_field_uc.dart';
import 'package:groovix/features/cms/artists/domain/usecase/create_artist_uc.dart';
import 'package:groovix/features/cms/artists/domain/usecase/get_artists_list_uc.dart';
import 'package:groovix/features/cms/artists/domain/usecase/get_artist_by_id_uc.dart';
import 'package:groovix/features/cms/artists/domain/usecase/update_artist_uc.dart';
import 'package:groovix/features/cms/artists/domain/usecase/delete_artist_uc.dart';
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

  // Artist UseCases
  getIt.registerLazySingleton<CreateArtistUc>(
      () => CreateArtistUc(artistRepository: getIt()));
  getIt.registerLazySingleton<GetArtistsListUc>(
      () => GetArtistsListUc(artistRepository: getIt()));
  getIt.registerLazySingleton<GetArtistByIdUc>(
      () => GetArtistByIdUc(artistRepository: getIt()));
  getIt.registerLazySingleton<UpdateArtistUc>(
      () => UpdateArtistUc(artistRepository: getIt()));
  getIt.registerLazySingleton<DeleteArtistUc>(
      () => DeleteArtistUc(artistRepository: getIt()));
}
