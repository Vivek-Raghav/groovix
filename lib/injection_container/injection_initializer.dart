import 'package:groovix/injection_container/injected/inject_datasource.dart';
import 'package:groovix/injection_container/injected/inject_repository.dart';
import 'package:groovix/injection_container/injected/inject_usecase.dart';
import 'package:groovix/injection_container/injection_index.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectionInit() async {
  await injectDatasources();
  await injectRepositories();
  await injectUsecases();
  await initializeStorage();
  await injectBlocs();
}
