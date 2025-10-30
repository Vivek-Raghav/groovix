// Project imports:
import 'package:groovix/core/local_db/local_cache.dart';
import 'package:groovix/core/services/api/api_service.dart';
import 'package:groovix/injection_container/injection_index.dart';
import 'package:groovix/main/flavor/flavor_config.dart';

Future<void> initializeStorage() async {
  final localCache = LocalCache();
  await localCache.init();

  getIt.registerSingleton<LocalCache>(localCache);
  getIt.registerSingleton<ApiService>(
      ApiService(baseUrl: FlavorConfig.instance.baseUrl));
}
