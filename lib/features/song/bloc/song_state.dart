// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:groovix/features/song/song_index.dart';

class SongState extends Equatable {
  final SongsListResponse? songsListResponse;
  final List<SongModel>? searchSongs;
  final List<SongModel>? recentSongs;
  final List<SongModel>? likedSongs;
  final String? error;
  final bool isLoading;

  const SongState({
    this.songsListResponse,
    this.searchSongs,
    this.recentSongs,
    this.likedSongs,
    this.error,
    this.isLoading = false,
  });

  SongState copyWith({
    SongsListResponse? songsListResponse,
    List<SongModel>? searchSongs,
    List<SongModel>? recentSongs,
    List<SongModel>? likedSongs,
    String? error,
    bool? isLoading,
  }) {
    return SongState(
      songsListResponse: songsListResponse ?? this.songsListResponse,
      searchSongs: searchSongs ?? this.searchSongs,
      recentSongs: recentSongs ?? this.recentSongs,
      likedSongs: likedSongs ?? this.likedSongs,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        songsListResponse,
        searchSongs,
        recentSongs,
        likedSongs,
        error,
        isLoading,
      ];
}
