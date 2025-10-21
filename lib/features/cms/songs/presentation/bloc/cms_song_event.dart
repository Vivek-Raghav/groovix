// Events
import 'package:groovix/features/cms/songs/domain/models/upload_song_model.dart';
import 'package:groovix/features/cms/songs/domain/models/cms_song_update_model.dart';
import 'package:groovix/features/navigation_bar/navigation_index.dart';

abstract class SongEvent {}

class SearchSongs extends SongEvent {
  final String query;
  SearchSongs(this.query);
}

class DeleteSong extends SongEvent {
  final String songId;
  DeleteSong(this.songId);
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
