import 'package:groovix/main/main_index.dart';
import 'package:groovix/main.dart' as run;

void main() async {
  initFlavorConfig(Flavor.prod);
  await run.main();
}
