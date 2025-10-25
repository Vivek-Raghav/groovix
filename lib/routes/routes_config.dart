// Project imports:
import 'package:groovix/core/models/artist_model.dart';
import 'package:groovix/features/cms/cms_screen.dart';
import 'package:groovix/features/cms/shared/screens/universal_edit_success_screen.dart';
import 'package:groovix/features/cms/songs/domain/models/upload_song_response.dart';
import 'package:groovix/features/cms/songs/presentation/screens/cms_edit_song_screen.dart';
import 'package:groovix/features/cms/songs/presentation/screens/cms_upload_song.dart';
import 'package:groovix/features/cms/songs/presentation/screens/song_upload_success_screen.dart';
import 'package:groovix/features/cms/artists/presentation/screens/cms_add_artist_screen.dart';
import 'package:groovix/features/cms/artists/presentation/screens/cms_edit_artist_screen.dart';
import 'package:groovix/features/cms/artists/presentation/bloc/artist_bloc.dart';
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
          context: context, state: state, child: const MainNavigationScreen()),
    ),
    GoRoute(
      path: AppRoutes.explore,
      pageBuilder: (context, state) => customTransitionPage(
          context: context,
          state: state,
          child: const MainNavigationScreen(index: 1)),
    ),
    GoRoute(
      path: AppRoutes.library,
      pageBuilder: (context, state) => customTransitionPage(
          context: context,
          state: state,
          child: const MainNavigationScreen(index: 2)),
    ),
    GoRoute(
      path: AppRoutes.playlist,
      pageBuilder: (context, state) => customTransitionPage(
          context: context,
          state: state,
          child: const MainNavigationScreen(index: 3)),
    ),
    GoRoute(
      path: AppRoutes.settings,
      pageBuilder: (context, state) => customTransitionPage(
          context: context,
          state: state,
          child: const MainNavigationScreen(index: 4)),
    ),
    GoRoute(
      path: AppRoutes.library,
      pageBuilder: (context, state) => customTransitionPage(
          context: context, state: state, child: const LibraryScreen()),
    ),
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) => customTransitionPage(
          context: context, state: state, child: const LoginScreen()),
    ),
    GoRoute(
      path: AppRoutes.signup,
      pageBuilder: (context, state) => customTransitionPage(
          context: context, state: state, child: const SignupScreen()),
    ),
    GoRoute(
      path: AppRoutes.uploadSong,
      pageBuilder: (context, state) => customTransitionPage(
          context: context, state: state, child: const UploadSongScreen()),
    ),
    GoRoute(
      path: AppRoutes.uploadSuccess,
      pageBuilder: (context, state) {
        final uploadResponse = state.extra as UploadSongResponse?;
        return customTransitionPage(
          context: context,
          state: state,
          child: SongUploadSuccessScreen(uploadResponse: uploadResponse!),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.editSong,
      pageBuilder: (context, state) {
        final song = state.extra as SongModel;
        return customTransitionPage(
          context: context,
          state: state,
          child: EditSongScreen(song: song),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.editSuccess,
      pageBuilder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return customTransitionPage(
            context: context,
            state: state,
            child: UniversalEditSuccessScreen(
                type: data['type'],
                title: data['title'],
                message: data['message'],
                data: data));
      },
    ),
    GoRoute(
      path: AppRoutes.fullMusic,
      pageBuilder: (context, state) => customTransitionPage(
          context: context, state: state, child: const FullMusicScreen()),
    ),
    GoRoute(
      path: AppRoutes.addArtist,
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: BlocProvider.value(
          value: getIt<CmsArtistBloc>(),
          child: const CMSAddArtistScreen(),
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.editArtist,
      pageBuilder: (context, state) {
        final artist = state.extra as ArtistModel;
        return customTransitionPage(
          context: context,
          state: state,
          child: BlocProvider.value(
            value: getIt<CmsArtistBloc>(),
            child: CMSEditArtistScreen(artist: artist),
          ),
        );
      },
    ),
  ],
);
