import 'package:flutter/material.dart';
import 'package:groovix/core/constants/global_const.dart';
import 'package:groovix/core/theme/app_theme.dart';
import 'package:groovix/routes/routes_config.dart';

class Entry extends StatelessWidget {
  const Entry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: GlobalKeys.rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: "groovix",
      theme: lightTheme(context),
      routerConfig: appRouter,
    );
  }
}
