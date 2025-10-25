// models/song_model.dart
class SongModel {
  final String id;
  final String songUrl;
  final String thumbnailUrl;
  final String artistName;
  final String artistId;
  final String songName;
  final String hexcode;

  SongModel(
      {required this.id,
      required this.songUrl,
      required this.thumbnailUrl,
      required this.artistName,
      required this.artistId,
      required this.songName,
      required this.hexcode});

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'] ?? '',
      songUrl: json['song_url'] ?? '',
      thumbnailUrl: json['thumbnail_url'] ?? '',
      artistName: json['artist_name'] ?? '',
      artistId: json['artist_id'] ?? '',
      songName: json['song_name'] ?? '',
      hexcode: json['hexcode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'song_url': songUrl,
      'thumbnail_url': thumbnailUrl,
      'artist_name': artistName,
      'artist_id': artistId,
      'song_name': songName,
      'hexcode': hexcode,
    };
  }

  @override
  String toString() {
    return 'SongModel(id: $id, songUrl: $songUrl, thumbnailUrl: $thumbnailUrl, artistName: $artistName, artistId: $artistId, songName: $songName, hexcode: $hexcode,)';
  }
}
