import 'package:groovix/features/auth/bloc/auth_bloc.dart';
import 'package:groovix/features/cms/cms_index.dart';
import 'package:groovix/features/shared/playlist/playlist_index.dart';
import 'package:groovix/features/song/bloc/song_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectBlocs() async {
  getIt.registerLazySingleton<AuthBloc>(
      () => AuthBloc(loginUc: getIt(), signupUc: getIt(), logoutUc: getIt()));
  getIt.registerLazySingleton<SongCubit>(
    () => SongCubit(
      songListUc: getIt(),
      searchSongUc: getIt(),
      recentSongsUc: getIt(),
      likedSongsUc: getIt()
    ),
  );
  getIt.registerLazySingleton<MusicPlayerManager>(() => MusicPlayerManager());
  getIt.registerLazySingleton<MusicPlayerBloc>(() => MusicPlayerBloc(
        getIt(),
        getIt(),
        getIt(),
      ));

  // CMS BLoCs
  getIt.registerLazySingleton<DashboardBloc>(() => DashboardBloc(getIt()));
  getIt.registerLazySingleton<CmsSongBloc>(() => CmsSongBloc(
      uploadSongUc: getIt(),
      songListUc: getIt(),
      updateSongFieldsUc: getIt(),
      deleteSongUc: getIt(),
      searchSongUc: getIt()));
  getIt.registerLazySingleton<CmsArtistBloc>(() => CmsArtistBloc(
      createArtistUc: getIt(),
      getArtistsListUc: getIt(),
      getArtistByIdUc: getIt(),
      updateArtistUc: getIt(),
      deleteArtistUc: getIt()));
  getIt.registerLazySingleton<CmsGenreBloc>(() => CmsGenreBloc(
      createGenreUc: getIt(),
      getGenresListUc: getIt(),
      getGenreByIdUc: getIt(),
      updateGenreUc: getIt(),
      deleteGenreUc: getIt(),
      assignSongsToGenreUc: getIt(),
      removeSongsFromGenreUc: getIt(),
      getGenreSongsUc: getIt()));
  getIt.registerLazySingleton<PlaylistBloc>(() => PlaylistBloc(
      createPlaylistUc: getIt(),
      getPlaylistsListUc: getIt(),
      getPlaylistByIdUc: getIt(),
      updatePlaylistUc: getIt(),
      deletePlaylistUc: getIt(),
      addSongsToPlaylistUc: getIt(),
      removeSongsFromPlaylistUc: getIt(),
      getPlaylistSongsUc: getIt()));
}
