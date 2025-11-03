// Flutter imports:
import 'package:groovix/core/core_index.dart';
import 'package:groovix/injection_container/injection_initializer.dart';
import 'package:groovix/routes/routes_config.dart';

class Entry extends StatelessWidget {
  const Entry({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>.value(
      value: getIt<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
              scaffoldMessengerKey: GlobalKeys.rootScaffoldMessengerKey,
              debugShowCheckedModeBanner: false,
              title: "groovix",
              theme: lightTheme(context),
              darkTheme: darkTheme(context),
              themeMode: themeState.themeMode,
              routerConfig: appRouter);
        },
      ),
    );
  }
}
