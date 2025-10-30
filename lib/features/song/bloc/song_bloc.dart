// Project imports:
import 'package:groovix/features/cms/songs/domain/usecase/search_song_uc.dart';
import 'package:groovix/features/song/domain/usecase/liked_songs_uc.dart';
import 'package:groovix/features/song/domain/usecase/recent_songs_uc.dart';
import 'package:groovix/features/song/song_index.dart';

class SongCubit extends Cubit<SongState> {
  SongCubit({
    required this.searchSongUc,
    required this.songListUc,
    required this.recentSongsUc,
    required this.likedSongsUc,
  }) : super(const SongState());

  final SongListUc songListUc;
  final SearchSongUc searchSongUc;
  final RecentSongsUc recentSongsUc;
  final LikedSongsUc likedSongsUc;

  Future<void> getSongList(SongsQueryModel songPaginationModel) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await songListUc.call(songPaginationModel);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.toString())),
      (success) => emit(
        state.copyWith(isLoading: false, songsListResponse: success),
      ),
    );
  }

  // 🔍 Search songs
  Future<void> onSearchSongs(String query) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await searchSongUc.call(query);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.toString())),
      (songs) => emit(
        state.copyWith(isLoading: false, searchSongs: songs),
      ),
    );
  }

  // 🕒 Recent songs
  Future<void> getRecentSongs() async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await recentSongsUc.call(NoParams());

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.toString())),
      (songs) => emit(
        state.copyWith(isLoading: false, recentSongs: songs),
      ),
    );
  }

  // 🕒 Liked songs
  Future<void> getLikedSongs() async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await likedSongsUc.call(NoParams());

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.toString())),
      (songs) => emit(
        state.copyWith(isLoading: false, likedSongs: songs),
      ),
    );
  }

  Future<void> clearSearchSongs() async {
    emit(state.copyWith(searchSongs: []));
  }
}
