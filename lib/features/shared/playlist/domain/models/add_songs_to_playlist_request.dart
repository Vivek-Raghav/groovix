class AddSongsToPlaylistRequest {
  final List<String> songIds;

  AddSongsToPlaylistRequest({
    required this.songIds,
  });

  Map<String, dynamic> toJson() => {
        'song_ids': songIds,
      };
}
