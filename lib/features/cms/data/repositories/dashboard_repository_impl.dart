import '../../domain/models/dashboard_stats.dart';
import '../../domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<DashboardStats> getDashboardStats() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock dashboard stats
    return const DashboardStats(
      totalSongs: 1234,
      totalPlaylists: 45,
      totalGenres: 18,
      totalArtists: 56,
      recentUploads: 12,
    );
  }
}
