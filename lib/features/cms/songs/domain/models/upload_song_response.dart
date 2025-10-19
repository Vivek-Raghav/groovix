class UploadSongResponse {
  final String id;
  final String songUrl;
  final String thumbnailUrl;
  final String artist;
  final String songName;
  final String hexcode;

  UploadSongResponse({
    required this.id,
    required this.songUrl,
    required this.thumbnailUrl,
    required this.artist,
    required this.songName,
    required this.hexcode,
  });

  factory UploadSongResponse.fromJson(Map<String, dynamic> json) {
    return UploadSongResponse(
      id: json['id'] ?? '',
      songUrl: json['song_url'] ?? '',
      thumbnailUrl: json['thumbnail_url'] ?? '',
      artist: json['artist'] ?? '',
      songName: json['song_name'] ?? '',
      hexcode: json['hexcode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'song_url': songUrl,
        'thumbnail_url': thumbnailUrl,
        'artist': artist,
        'song_name': songName,
        'hexcode': hexcode,
      };
}
