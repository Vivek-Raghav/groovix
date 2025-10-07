// Project imports:

import 'package:groovix/features/song/data/repositories/song_repository_impl.dart';
import 'package:groovix/features/song/domain/repositories/song_repository.dart';
import 'package:groovix/injection_container/injection_index.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectRepositories() async {
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: getIt()));
  getIt.registerLazySingleton<SongRepository>(
      () => SongRepositoryImpl(songRemoteDataSource: getIt()));
}
