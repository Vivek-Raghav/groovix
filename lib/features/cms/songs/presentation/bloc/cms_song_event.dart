// Events
import 'package:groovix/features/cms/songs/domain/models/upload_song_model.dart';
import 'package:groovix/features/cms/songs/domain/models/cms_song_update_model.dart';
import 'package:groovix/features/navigation_bar/navigation_index.dart';

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

class UploadSong extends SongEvent {
  final UploadSongModel uploadSongModel;
  UploadSong(this.uploadSongModel);
}

class UpdateSongFields extends SongEvent {
  final String songId;
  final CmsSongUpdateModel updateModel;
  UpdateSongFields(this.songId, this.updateModel);
}

class FetchSongList extends SongEvent {
  final SongsQueryModel songsQueryModel;
  FetchSongList(this.songsQueryModel);
}
