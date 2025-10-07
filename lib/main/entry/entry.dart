// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:groovix/core/constants/global_const.dart';
import 'package:groovix/core/core_index.dart';
import 'package:groovix/routes/routes_config.dart';

class Entry extends StatefulWidget {
  const Entry({super.key});

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  final ThemeManager _themeManager = ThemeManager();

  @override
  void initState() {
    super.initState();
    _themeManager.initializeTheme();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeManager,
      builder: (context, child) {
        return MaterialApp.router(
          scaffoldMessengerKey: GlobalKeys.rootScaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          title: "groovix",
          theme: lightTheme(context),
          darkTheme: darkTheme(context),
          themeMode: _themeManager.themeMode,
          routerConfig: appRouter,
        );
      },
    );
  }
}
