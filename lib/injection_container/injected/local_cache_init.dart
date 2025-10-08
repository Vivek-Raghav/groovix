// Project imports:
import 'package:groovix/main/flavor/flavor_config.dart';
import 'package:groovix/core/constants/pref_keys.dart';
import 'package:groovix/core/local_db/local_cache.dart';
import 'package:groovix/core/services/api_service.dart';
import 'package:groovix/injection_container/injection_index.dart';

Future<void> initializeStorage() async {
  // Register Storage Dependencies
  final localCache = LocalCache();
  await localCache.init();

  getIt.registerSingleton<LocalCache>(localCache);
  getIt.registerSingleton<ApiService>(ApiService(
      baseUrl: FlavorConfig.instance.baseUrl,
      token: getIt<LocalCache>().getString(PrefKeys.token)));
}
