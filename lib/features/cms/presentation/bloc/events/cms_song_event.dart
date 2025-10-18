// Events
import 'package:groovix/core/shared/model/song_model.dart';

abstract class SongEvent {}

class LoadSongs extends SongEvent {}

class SearchSongs extends SongEvent {
  final String query;
  SearchSongs(this.query);
}

class CreateSong extends SongEvent {
  final SongModel song;
  CreateSong(this.song);
}

class UpdateSong extends SongEvent {
  final SongModel song;
  UpdateSong(this.song);
}

class DeleteSong extends SongEvent {
  final String songId;
  DeleteSong(this.songId);
}

class LoadRecentSongs extends SongEvent {
  final int limit;
  LoadRecentSongs({this.limit = 10});
}
