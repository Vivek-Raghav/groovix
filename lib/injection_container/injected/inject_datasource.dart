import 'package:groovix/injection_container/injection_index.dart';
import 'package:groovix/features/cms/data/datasources/cms_song_datasource_impl.dart';
import 'package:groovix/features/cms/data/datasources/cms_song_datasource.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectDatasources() async {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
  getIt.registerLazySingleton<SongRemoteDataSource>(
      () => SongRemoteDataSourceImpl());

  // CMS DataSources
  getIt.registerLazySingleton<CMSSongDataSource>(() => CMSSongDataSourceImpl());
}
