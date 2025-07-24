import 'package:groovix/routes/routes_index.dart';
import 'package:groovix/auth/login_screen.dart';
import 'package:groovix/auth/signup_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.initial,
  routes: [
    GoRoute(
      path: AppRoutes.initial,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const MainNavigationScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.settings,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const SettingsScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.explore,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const ExploreScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.library,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const LibraryScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.playlist,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const PlaylistScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.signup,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const SignupScreen(),
      ),
    ),
  ],
);
