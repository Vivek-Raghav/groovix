class AssignSongsToGenreRequest {
  final List<String> songIds;

  AssignSongsToGenreRequest({
    required this.songIds,
  });

  Map<String, dynamic> toJson() => {
        'song_ids': songIds,
      };
}
