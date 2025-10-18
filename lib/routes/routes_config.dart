// Project imports:
import 'package:groovix/features/cms/presentation/screens/cms_screen.dart';
import 'package:groovix/features/song/presentation/screens/full_music_screen.dart';
import 'package:groovix/routes/routes_index.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.initial,
  routes: [
    GoRoute(
      path: AppRoutes.initial,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.cmsDashboard,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const CMSScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.bottomNav,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const MainNavigationScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.explore,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const MainNavigationScreen(index: 1),
      ),
    ),
    GoRoute(
      path: AppRoutes.uploadSong,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const MainNavigationScreen(index: 2),
      ),
    ),
    GoRoute(
      path: AppRoutes.playlist,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const MainNavigationScreen(index: 3),
      ),
    ),
    GoRoute(
      path: AppRoutes.settings,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const MainNavigationScreen(index: 4),
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
    GoRoute(
      path: AppRoutes.uploadSuccess,
      pageBuilder: (context, state) {
        // Extract the upload response from state.extra
        final uploadResponse = state.extra as UploadSongResponse?;
        return customTransitionPage(
          context: context,
          state: state,
          child: SongUploadSuccessScreen(
            uploadResponse: uploadResponse!,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.fullMusic,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const FullMusicScreen(),
      ),
    ),
  ],
);
