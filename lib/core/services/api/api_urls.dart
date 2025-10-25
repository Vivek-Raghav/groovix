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

  // Artist endpoints
  static String get artistsBase => '/artists';
  static String get artistsCreate => '/artists/create';
  static String get artistsList => '/artists/list';
  static String get artistsUpdate => '/artists/update';
  static String get artistsDelete => '/artists/delete';
}
