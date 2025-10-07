// Project imports:
import 'package:groovix/features/auth/presentation/login_screen.dart';
import 'package:groovix/features/auth/presentation/signup_screen.dart';
import 'package:groovix/features/song/domain/models/upload_song_response.dart';
import 'package:groovix/features/song/presentation/upload_song.dart';
import 'package:groovix/features/song/presentation/screens/song_upload_success_screen.dart';
import 'package:groovix/main/entry/splash.dart';
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
      path: AppRoutes.bottomNav,
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
    GoRoute(
      path: AppRoutes.uploadSong,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const UploadSongScreen(),
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
  ],
);
