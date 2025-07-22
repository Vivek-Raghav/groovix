// Project imports:
import 'package:groovix/core/local_db/local_cache.dart';
import 'package:groovix/injection_container/injection_index.dart';

Future<void> initializeStorage() async {
  // Register Storage Dependencies
  final localCache = LocalCache();
  await localCache.init();

  getIt.registerSingleton<LocalCache>(localCache);
}
