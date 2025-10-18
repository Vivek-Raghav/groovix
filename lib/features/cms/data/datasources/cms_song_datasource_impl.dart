import '../../domain/models/song_model.dart';
import 'cms_song_datasource.dart';

class CMSSongDataSourceImpl implements CMSSongDataSource {
  // Mock data for demonstration - replace with actual API calls
  static final List<SongModel> _mockSongs = [
    SongModel(
      id: '1',
      name: 'Summer Vibes',
      artist: 'John Doe',
      genres: ['Pop', 'Electronic'],
      categories: ['Featured', 'New Release'],
      audioUrl: 'https://example.com/audio1.mp3',
      thumbnailUrl: 'https://example.com/thumb1.jpg',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      duration: 180,
    ),
    SongModel(
      id: '2',
      name: 'Midnight Dreams',
      artist: 'Jane Smith',
      genres: ['Rock', 'Alternative'],
      categories: ['Popular'],
      audioUrl: 'https://example.com/audio2.mp3',
      thumbnailUrl: 'https://example.com/thumb2.jpg',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
      duration: 240,
    ),
    SongModel(
      id: '3',
      name: 'City Lights',
      artist: 'Mike Johnson',
      genres: ['Hip Hop', 'Urban'],
      categories: ['Trending'],
      audioUrl: 'https://example.com/audio3.mp3',
      thumbnailUrl: 'https://example.com/thumb3.jpg',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now(),
      duration: 200,
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
            song.name.toLowerCase().contains(query.toLowerCase()) ||
            song.artist.toLowerCase().contains(query.toLowerCase()) ||
            song.genres.any(
                (genre) => genre.toLowerCase().contains(query.toLowerCase())))
        .toList();
  }

  @override
  Future<SongModel> createSong(SongModel song) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final newSong = song.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _mockSongs.add(newSong);
    return newSong;
  }

  @override
  Future<SongModel> updateSong(SongModel song) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockSongs.indexWhere((s) => s.id == song.id);
    if (index != -1) {
      final updatedSong = song.copyWith(updatedAt: DateTime.now());
      _mockSongs[index] = updatedSong;
      return updatedSong;
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
    final sortedSongs = List<SongModel>.from(_mockSongs)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sortedSongs.take(limit).toList();
  }
}
