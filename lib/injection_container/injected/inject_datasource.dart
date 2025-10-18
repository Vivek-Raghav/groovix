import 'package:groovix/features/cms/cms_index.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectDatasources() async {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
  getIt.registerLazySingleton<SongRemoteDataSource>(
      () => SongRemoteDataSourceImpl());

  // CMS DataSources
  getIt.registerLazySingleton<CmsSongRemoteDataSource>(
      () => CmsSongRemoteDatasourceImpl());
}
