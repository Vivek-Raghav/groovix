// Project imports:
import 'package:groovix/main.dart' as run;
import 'package:groovix/main/main_index.dart';

void main() async {
  initFlavorConfig(Flavor.dev);
  await run.main();
}
