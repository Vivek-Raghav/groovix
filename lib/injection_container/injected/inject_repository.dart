// Project imports:
import 'package:groovix/features/cms/cms_index.dart';
import 'package:groovix/features/shared/playlist/playlist_index.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectRepositories() async {
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: getIt()));
  getIt.registerLazySingleton<SongRepository>(
      () => SongRepositoryImpl(songRemoteDataSource: getIt()));

  // CMS Repositories
  getIt.registerLazySingleton<CmsSongRepository>(
      () => CmsSongRepositoryImpl(cmsSongRemoteDataSource: getIt()));
  getIt.registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl());
  getIt.registerLazySingleton<ArtistRepository>(
      () => ArtistRepositoryImpl(datasource: getIt()));
  getIt.registerLazySingleton<GenreRepository>(
      () => GenreRepositoryImpl(datasource: getIt()));
  getIt.registerLazySingleton<PlaylistRepository>(
      () => PlaylistRepositoryImpl(datasource: getIt()));
}
