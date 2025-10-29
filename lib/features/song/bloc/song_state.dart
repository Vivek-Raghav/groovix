import 'package:equatable/equatable.dart';
import 'package:groovix/features/song/song_index.dart';

class SongState extends Equatable {
  final SongsListResponse? songsListResponse;
  final List<SongModel>? searchSongs;
  final List<SongModel>? recentSongs;
  final String? error;
  final bool isLoading;

  const SongState({
    this.songsListResponse,
    this.searchSongs,
    this.recentSongs,
    this.error,
    this.isLoading = false,
  });

  SongState copyWith({
    SongsListResponse? songsListResponse,
    List<SongModel>? searchSongs,
    List<SongModel>? recentSongs,
    String? error,
    bool? isLoading,
  }) {
    return SongState(
      songsListResponse: songsListResponse ?? this.songsListResponse,
      searchSongs: searchSongs ?? this.searchSongs,
      recentSongs: recentSongs ?? this.recentSongs,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        songsListResponse,
        searchSongs,
        recentSongs,
        error,
        isLoading,
      ];
}
