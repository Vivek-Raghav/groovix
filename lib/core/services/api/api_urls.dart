class ApiUrls {
  // Auth endpoints
  static String get login => '/auth/login';
  static String get signup => '/auth/signup';
  static String get logout => '/auth/logout';
  static String get refreshToken => '/auth/refresh';

  // Song endpoints
  static String get uploadSong => '/songs/upload';
  static String get getSongList => '/songs/list';
  static String get updateSongFlags => '/flags/update';
  static String get getRecentSongs => '/songs/recent';
  static String get getLikedSongs => '/songs/liked';
  static String getSongFlags(String userId, String songId) =>
      '/flags/user/$userId/song/$songId';

  // Artist endpoints
  static String get artistsBase => '/artists';
  static String get artistsCreate => '/artists/create';
  static String get artistsList => '/artists/list';
  static String get artistsUpdate => '/artists/update';
  static String get artistsDelete => '/artists/delete';

  // Genre endpoints
  static String get genresBase => '/genres';
  static String get genresCreate => '/genres/create';
  static String get genresList => '/genres/list';
  static String get genresUpdate => '/genres/update';
  static String get genresDelete => '/genres/delete';

  // Playlist endpoints
  static String get playlistsBase => '/playlists';
  static String get playlistsCreate => '/playlists/create';
  static String get playlistsList => '/playlists/list';
  static String get playlistsUpdate => '/playlists/update';
  static String get playlistsDelete => '/playlists/delete';
  static String playlistsAddSongs(String playlistId) =>
      '/playlists/add-songs/$playlistId';
  static String playlistsRemoveSongs(String playlistId) =>
      '/playlists/remove-songs/$playlistId';

  // Genre endpoints
  static String genresAssignSongs(String genreId) =>
      '/genres/assign-songs/$genreId';
  static String genresRemoveSongs(String genreId) =>
      '/genres/remove-songs/$genreId';
  static String getPlaylistSongs(String playlistId) =>
      '/playlists/$playlistId/songs';
  static String getGenreSongs(String genreId) => '/genres/$genreId/songs';
}
