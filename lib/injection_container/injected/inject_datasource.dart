// Project imports:
import 'package:groovix/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:groovix/features/song/data/datasource/song_datasource.dart';
import 'package:groovix/features/song/data/datasource/song_datasource_impl.dart';
import 'package:groovix/injection_container/injection_index.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectDatasources() async {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
  getIt.registerLazySingleton<SongRemoteDataSource>(
      () => SongRemoteDataSourceImpl());
}
