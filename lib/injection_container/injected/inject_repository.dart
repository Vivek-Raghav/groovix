import 'package:groovix/injection_container/injection_index.dart';
import 'package:groovix/features/cms/data/repositories/cms_song_repository_impl.dart';
import 'package:groovix/features/cms/data/repositories/dashboard_repository_impl.dart';
import 'package:groovix/features/cms/domain/repositories/cms_song_repository.dart';
import 'package:groovix/features/cms/domain/repositories/dashboard_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectRepositories() async {
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: getIt()));
  getIt.registerLazySingleton<SongRepository>(
      () => SongRepositoryImpl(songRemoteDataSource: getIt()));

  // CMS Repositories
  getIt.registerLazySingleton<CMSSongRepository>(
      () => CMSSongRepositoryImpl(getIt()));
  getIt.registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl());
}
