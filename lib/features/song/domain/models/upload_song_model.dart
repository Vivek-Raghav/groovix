// Dart imports:
import 'dart:io';

class UploadSongModel {
  File thumbnailFile;
  File song;
  String artist;
  String songName;
  String hexcode;

  UploadSongModel({
    required this.thumbnailFile,
    required this.song,
    required this.artist,
    required this.songName,
    required this.hexcode,
  });

  factory UploadSongModel.fromJson(Map<String, dynamic> json) {
    return UploadSongModel(
      thumbnailFile: File(json['thumbnailFile'] as String),
      song: File(json['song'] as String),
      artist: json['artist'] as String,
      songName: json['song_name'] as String,
      hexcode: json['hexcode'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'thumbnailFile': thumbnailFile.path,
      'song': song.path,
      'artist': artist,
      'song_name': songName,
      'selectedColor': hexcode,
    };
  }
}
