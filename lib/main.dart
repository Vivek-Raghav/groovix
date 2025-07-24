// ignore_for_file: unnecessary_null_comparison

// Project imports:
import 'package:groovix/main/main_index.dart';

Future<void> main() async {
  FlavorConfig.isInitialized ? null : initFlavorConfig(Flavor.dev);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await injectionInit();
  runApp(const Entry());
}
