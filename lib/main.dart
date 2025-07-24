// ignore_for_file: unnecessary_null_comparison

// Project imports:
import 'package:groovix/core/initialization/initialization_manager.dart';
import 'package:groovix/main/main_index.dart';

Future<void> main() async {
  FlavorConfig.isInitialized ? null : initFlavorConfig(Flavor.dev);
  WidgetsFlutterBinding.ensureInitialized();
  await InitializationManager.initialize();
  runApp(const Entry());
}
