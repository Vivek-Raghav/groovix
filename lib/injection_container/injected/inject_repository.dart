import 'package:groovix/features/cms/cms_index.dart';

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
}
