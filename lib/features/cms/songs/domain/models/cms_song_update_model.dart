class CmsSongUpdateModel {
  final String? songName;
  final String? artist;
  final String? hexcode;

  CmsSongUpdateModel({
    this.songName,
    this.artist,
    this.hexcode,
  });

  factory CmsSongUpdateModel.fromJson(Map<String, dynamic> json) {
    return CmsSongUpdateModel(
      songName: json['song_name'],
      artist: json['artist'],
      hexcode: json['hexcode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    // Only include non-null fields in the JSON
    if (songName != null) data['song_name'] = songName;
    if (artist != null) data['artist'] = artist;
    if (hexcode != null) data['hexcode'] = hexcode;

    return data;
  }

  @override
  String toString() {
    return 'CmsSongUpdateModel(songName: $songName, artist: $artist, hexcode: $hexcode)';
  }

  // Helper method to check if any field is provided
  bool get hasFields => songName != null || artist != null || hexcode != null;

  // Helper method to get the number of fields being updated
  int get fieldCount {
    int count = 0;
    if (songName != null) count++;
    if (artist != null) count++;
    if (hexcode != null) count++;
    return count;
  }
}
