// Project imports:

import "package:groovix/features/cms/cms_index.dart";

class CmsSongRemoteDatasourceImpl extends CmsSongRemoteDataSource {
  final apiService = getIt<ApiService>();

  // Mock data for demonstration - replace with actual API calls
  static final List<SongModel> _mockSongs = [
    SongModel(
      id: '1',
      songName: 'Summer Vibes',
      artist: 'John Doe',
      songUrl: 'https://example.com/audio1.mp3',
      thumbnailUrl: 'https://example.com/thumb1.jpg',
      hexcode: '#FF6B6B',
    ),
    SongModel(
      id: '2',
      songName: 'Midnight Dreams',
      artist: 'Jane Smith',
      songUrl: 'https://example.com/audio2.mp3',
      thumbnailUrl: 'https://example.com/thumb2.jpg',
      hexcode: '#4ECDC4',
    ),
    SongModel(
      id: '3',
      songName: 'City Lights',
      artist: 'Mike Johnson',
      songUrl: 'https://example.com/audio3.mp3',
      thumbnailUrl: 'https://example.com/thumb3.jpg',
      hexcode: '#45B7D1',
    ),
    SongModel(
      id: '4',
      songName: 'Ocean Waves',
      artist: 'Sarah Wilson',
      songUrl: 'https://example.com/audio4.mp3',
      thumbnailUrl: 'https://example.com/thumb4.jpg',
      hexcode: '#96CEB4',
    ),
    SongModel(
      id: '5',
      songName: 'Mountain High',
      artist: 'David Brown',
      songUrl: 'https://example.com/audio5.mp3',
      thumbnailUrl: 'https://example.com/thumb5.jpg',
      hexcode: '#FFEAA7',
    ),
  ];

  @override
  Future<List<SongModel>> getAllSongs() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_mockSongs);
  }

  @override
  Future<SongModel?> getSongById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _mockSongs.firstWhere((song) => song.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<SongModel>> searchSongs(String query) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (query.isEmpty) return getAllSongs();

    return _mockSongs
        .where((song) =>
            song.songName.toLowerCase().contains(query.toLowerCase()) ||
            song.artist.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<SongModel> createSong(SongModel song) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final newSong = SongModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      songName: song.songName,
      artist: song.artist,
      songUrl: song.songUrl,
      thumbnailUrl: song.thumbnailUrl,
      hexcode: song.hexcode,
    );
    _mockSongs.add(newSong);
    return newSong;
  }

  @override
  Future<SongModel> updateSong(SongModel song) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockSongs.indexWhere((s) => s.id == song.id);
    if (index != -1) {
      _mockSongs[index] = song;
      return song;
    }
    throw Exception('Song not found');
  }

  @override
  Future<void> deleteSong(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _mockSongs.removeWhere((song) => song.id == id);
  }

  @override
  Future<List<SongModel>> getRecentSongs({int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Since SongModel doesn't have createdAt, we'll return the first N songs
    // In a real implementation, you would sort by creation date
    return _mockSongs.take(limit).toList();
  }

  @override
  Future<UploadSongResponse> uploadSong(UploadSongModel params) async {
    try {
      final response =
          await apiService.postMultipart(url: ApiUrls.uploadSong, files: {
        'song': params.song,
        'thumbnail': params.thumbnailFile,
      }, fields: {
        'artist': params.artist,
        'song_name': params.songName,
        'hexcode': params.hexcode,
      });
      if (response.statusCode == 201) {
        return UploadSongResponse.fromJson(response.data);
      } else {
        debugPrint("Song Status Code: ${response.statusCode}");
        return throw ServerException(
            error: StringConstants.strSomethingWentWrong);
      }
    } catch (e) {
      debugPrint("Song Upload Error: $e");
      return throw ServerException(
          error: StringConstants.strSomethingWentWrong);
    }
  }
}
