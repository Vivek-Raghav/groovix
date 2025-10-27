// Project imports:
import 'package:groovix/features/cms/cms_index.dart';
import 'package:groovix/features/shared/playlist/playlist_index.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectDatasources() async {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
  getIt.registerLazySingleton<SongRemoteDataSource>(
      () => SongRemoteDataSourceImpl());

  // CMS DataSources
  getIt.registerLazySingleton<CmsSongRemoteDataSource>(
      () => CmsSongRemoteDatasourceImpl());
  getIt.registerLazySingleton<ArtistDatasource>(
      () => ArtistRemoteDatasourceImpl(apiService: getIt()));
  getIt.registerLazySingleton<GenreDatasource>(
      () => GenreRemoteDatasourceImpl());
  getIt.registerLazySingleton<PlaylistDatasource>(
      () => PlaylistRemoteDatasourceImpl());
}
