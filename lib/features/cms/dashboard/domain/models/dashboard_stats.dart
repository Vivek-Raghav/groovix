class DashboardStats {
  final int totalSongs;
  final int totalPlaylists;
  final int totalGenres;
  final int totalArtists;
  final int recentUploads;

  const DashboardStats({
    required this.totalSongs,
    required this.totalPlaylists,
    required this.totalGenres,
    required this.totalArtists,
    required this.recentUploads,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalSongs: json['totalSongs'] as int,
      totalPlaylists: json['totalPlaylists'] as int,
      totalGenres: json['totalGenres'] as int,
      totalArtists: json['totalArtists'] as int,
      recentUploads: json['recentUploads'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalSongs': totalSongs,
      'totalPlaylists': totalPlaylists,
      'totalGenres': totalGenres,
      'totalArtists': totalArtists,
      'recentUploads': recentUploads,
    };
  }

  @override
  String toString() {
    return 'DashboardStats(totalSongs: $totalSongs, totalPlaylists: $totalPlaylists, totalGenres: $totalGenres, totalArtists: $totalArtists)';
  }
}
