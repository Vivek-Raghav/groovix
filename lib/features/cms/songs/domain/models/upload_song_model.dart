// Dart imports:
import 'dart:io';

class UploadSongModel {
  File thumbnailFile;
  File song;
  String artistId;
  String songName;
  String hexcode;

  UploadSongModel({
    required this.thumbnailFile,
    required this.song,
    required this.artistId,
    required this.songName,
    required this.hexcode,
  });

  factory UploadSongModel.fromJson(Map<String, dynamic> json) {
    return UploadSongModel(
      thumbnailFile: File(json['thumbnail'] as String),
      song: File(json['song'] as String),
      artistId: json['artist_id'] as String,
      songName: json['song_name'] as String,
      hexcode: json['hexcode'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'thumbnailFile': thumbnailFile.path,
      'song': song.path,
      'artist_id': artistId,
      'song_name': songName,
      'hexcode': hexcode,
    };
  }
}
