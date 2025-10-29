// Project imports:
import 'package:groovix/features/cms/songs/domain/usecase/cms_upload_song_uc.dart';
import 'package:groovix/features/cms/songs/domain/usecase/delete_song_uc.dart';
import 'package:groovix/features/cms/songs/domain/usecase/search_song_uc.dart';
import 'package:groovix/features/cms/songs/domain/usecase/update_song_field_uc.dart';
import 'package:groovix/features/cms/artists/domain/usecase/create_artist_uc.dart';
import 'package:groovix/features/cms/artists/domain/usecase/get_artists_list_uc.dart';
import 'package:groovix/features/cms/artists/domain/usecase/get_artist_by_id_uc.dart';
import 'package:groovix/features/cms/artists/domain/usecase/update_artist_uc.dart';
import 'package:groovix/features/cms/artists/domain/usecase/delete_artist_uc.dart';
import 'package:groovix/features/cms/genres/domain/usecase/create_genre_uc.dart';
import 'package:groovix/features/cms/genres/domain/usecase/get_genres_list_uc.dart';
import 'package:groovix/features/cms/genres/domain/usecase/get_genre_by_id_uc.dart';
import 'package:groovix/features/cms/genres/domain/usecase/update_genre_uc.dart';
import 'package:groovix/features/cms/genres/domain/usecase/delete_genre_uc.dart';
import 'package:groovix/features/cms/genres/domain/usecase/assign_songs_to_genre_uc.dart';
import 'package:groovix/features/cms/genres/domain/usecase/remove_songs_from_genre_uc.dart';
import 'package:groovix/features/shared/playlist/domain/usecase/add_songs_to_playlist_uc.dart';
import 'package:groovix/features/shared/playlist/domain/usecase/remove_songs_from_playlist_uc.dart';
import 'package:groovix/features/shared/playlist/domain/usecase/get_playlist_songs_uc.dart';
import 'package:groovix/features/cms/genres/domain/usecase/get_genre_songs_uc.dart';
import 'package:groovix/features/song/domain/usecase/get_song_flags_uc.dart';
import 'package:groovix/features/song/domain/usecase/recent_songs_uc.dart';
import 'package:groovix/features/song/domain/usecase/update_song_flags_uc.dart';
import 'package:groovix/features/shared/playlist/playlist_index.dart';
import 'package:groovix/injection_container/injection_index.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectUsecases() async {
  getIt.registerLazySingleton<LoginUc>(() => LoginUc(authRepository: getIt()));
  getIt
      .registerLazySingleton<SignupUc>(() => SignupUc(authRepository: getIt()));
  getIt
      .registerLazySingleton<LogoutUc>(() => LogoutUc(authRepository: getIt()));
  getIt.registerLazySingleton<UploadSongUc>(
      () => UploadSongUc(cmsSongRepository: getIt()));
  getIt.registerLazySingleton<SearchSongUc>(
      () => SearchSongUc(cmsSongRepository: getIt()));
  getIt.registerLazySingleton<SongListUc>(
      () => SongListUc(songRepository: getIt()));
  getIt.registerLazySingleton<UpdateSongFieldsUseCase>(
      () => UpdateSongFieldsUseCase(getIt()));
  getIt.registerLazySingleton<DeleteSongUc>(
      () => DeleteSongUc(cmsSongRepository: getIt()));
  getIt.registerFactory<UpdateSongFlagsUc>(
      () => UpdateSongFlagsUc(songRepository: getIt()));
  getIt.registerFactory<GetSongFlagsUc>(
      () => GetSongFlagsUc(songRepository: getIt()));
  getIt.registerLazySingleton<RecentSongsUc>(
      () => RecentSongsUc(songRepository: getIt()));

  // Artist UseCases
  getIt.registerLazySingleton<CreateArtistUc>(
      () => CreateArtistUc(artistRepository: getIt()));
  getIt.registerLazySingleton<GetArtistsListUc>(
      () => GetArtistsListUc(artistRepository: getIt()));
  getIt.registerLazySingleton<GetArtistByIdUc>(
      () => GetArtistByIdUc(artistRepository: getIt()));
  getIt.registerLazySingleton<UpdateArtistUc>(
      () => UpdateArtistUc(artistRepository: getIt()));
  getIt.registerLazySingleton<DeleteArtistUc>(
      () => DeleteArtistUc(artistRepository: getIt()));

  // Genre UseCases
  getIt.registerLazySingleton<CreateGenreUc>(
      () => CreateGenreUc(genreRepository: getIt()));
  getIt.registerLazySingleton<GetGenresListUc>(
      () => GetGenresListUc(genreRepository: getIt()));
  getIt.registerLazySingleton<GetGenreByIdUc>(
      () => GetGenreByIdUc(genreRepository: getIt()));
  getIt.registerLazySingleton<UpdateGenreUc>(
      () => UpdateGenreUc(genreRepository: getIt()));
  getIt.registerLazySingleton<DeleteGenreUc>(
      () => DeleteGenreUc(genreRepository: getIt()));
  getIt.registerLazySingleton<AssignSongsToGenreUc>(
      () => AssignSongsToGenreUc(genreRepository: getIt()));
  getIt.registerLazySingleton<RemoveSongsFromGenreUc>(
      () => RemoveSongsFromGenreUc(genreRepository: getIt()));

  // Playlist UseCases
  getIt.registerLazySingleton<CreatePlaylistUc>(
      () => CreatePlaylistUc(playlistRepository: getIt()));
  getIt.registerLazySingleton<GetPlaylistsListUc>(
      () => GetPlaylistsListUc(playlistRepository: getIt()));
  getIt.registerLazySingleton<GetPlaylistByIdUc>(
      () => GetPlaylistByIdUc(playlistRepository: getIt()));
  getIt.registerLazySingleton<UpdatePlaylistUc>(
      () => UpdatePlaylistUc(playlistRepository: getIt()));
  getIt.registerLazySingleton<DeletePlaylistUc>(
      () => DeletePlaylistUc(playlistRepository: getIt()));
  getIt.registerLazySingleton<AddSongsToPlaylistUc>(
      () => AddSongsToPlaylistUc(playlistRepository: getIt()));
  getIt.registerLazySingleton<RemoveSongsFromPlaylistUc>(
      () => RemoveSongsFromPlaylistUc(playlistRepository: getIt()));
  getIt.registerLazySingleton<GetPlaylistSongsUc>(
      () => GetPlaylistSongsUc(playlistRepository: getIt()));
  getIt.registerLazySingleton<GetGenreSongsUc>(
      () => GetGenreSongsUc(genreRepository: getIt()));
}
