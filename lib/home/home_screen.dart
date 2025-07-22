import 'package:flutter/material.dart';

/// HomeScreen - Main landing page of the Groovix music app
///
/// This screen demonstrates several Flutter UI patterns and best practices:
/// - Responsive design with MediaQuery
/// - Custom widgets for reusability
/// - State management patterns
/// - Modern Material Design 3 components
/// - Proper theming and styling
/// - Accessibility considerations
///
/// Perfect for beginner developers to learn from!
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State variables for interactive elements
  bool _isPlaying = false;
  int _selectedCategoryIndex = 0;

  // Sample data - in a real app, this would come from an API or database
  final List<String> _categories = [
    'All',
    'Pop',
    'Rock',
    'Hip Hop',
    'Jazz',
    'Classical',
    'Electronic',
  ];

  final List<Map<String, dynamic>> _featuredPlaylists = [
    {
      'title': 'Today\'s Top Hits',
      'subtitle': 'The hottest tracks right now',
      'imageUrl': 'https://picsum.photos/200/200?random=1',
      'color': Colors.red,
    },
    {
      'title': 'Chill Vibes',
      'subtitle': 'Relaxing music for your day',
      'imageUrl': 'https://picsum.photos/200/200?random=2',
      'color': Colors.blue,
    },
    {
      'title': 'Workout Mix',
      'subtitle': 'High energy tracks to keep you moving',
      'imageUrl': 'https://picsum.photos/200/200?random=3',
      'color': Colors.green,
    },
    {
      'title': 'Study Focus',
      'subtitle': 'Concentration music for productivity',
      'imageUrl': 'https://picsum.photos/200/200?random=4',
      'color': Colors.purple,
    },
  ];

  final List<Map<String, dynamic>> _recentTracks = [
    {
      'title': 'Blinding Lights',
      'artist': 'The Weeknd',
      'duration': '3:20',
      'imageUrl': 'https://picsum.photos/100/100?random=5',
    },
    {
      'title': 'Shape of You',
      'artist': 'Ed Sheeran',
      'duration': '3:53',
      'imageUrl': 'https://picsum.photos/100/100?random=6',
    },
    {
      'title': 'Dance Monkey',
      'artist': 'Tones and I',
      'duration': '3:29',
      'imageUrl': 'https://picsum.photos/100/100?random=7',
    },
    {
      'title': 'Uptown Funk',
      'artist': 'Mark Ronson ft. Bruno Mars',
      'duration': '3:55',
      'imageUrl': 'https://picsum.photos/100/100?random=8',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;

    return Scaffold(
      // Custom app bar with gradient background
      appBar: _buildAppBar(context),

      // Main content with proper scrolling
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome section
              _buildWelcomeSection(context),

              const SizedBox(height: 24),

              // Category filter chips
              _buildCategoryFilter(context),

              const SizedBox(height: 24),

              // Featured playlists section
              _buildFeaturedPlaylists(context, isTablet),

              const SizedBox(height: 32),

              // Recently played tracks
              _buildRecentTracks(context),

              const SizedBox(height: 100), // Bottom padding for FAB
            ],
          ),
        ),
      ),

      // Floating action button for quick actions
      floatingActionButton: _buildFloatingActionButton(context),

      // Bottom navigation (placeholder for future implementation)
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  /// Custom app bar with gradient background and user avatar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
            ],
          ),
        ),
      ),
      title: Row(
        children: [
          // App logo/icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.music_note,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Groovix',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
      actions: [
        // Search button
        IconButton(
          onPressed: () => _showSearchDialog(context),
          icon: const Icon(Icons.search, color: Colors.white),
          tooltip: 'Search music',
        ),
        // Notifications button
        IconButton(
          onPressed: () => _showNotifications(context),
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          tooltip: 'Notifications',
        ),
        // User profile button
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.2),
            child: const Icon(Icons.person, color: Colors.white),
          ),
        ),
      ],
    );
  }

  /// Welcome section with personalized greeting
  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.1),
            Theme.of(context).primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good ${_getGreeting()}!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ready to discover your next favorite song?',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 16),
          // Quick stats row
          Row(
            children: [
              _buildStatCard(context, 'Playlists', '12'),
              const SizedBox(width: 12),
              _buildStatCard(context, 'Liked Songs', '47'),
              const SizedBox(width: 12),
              _buildStatCard(context, 'Following', '23'),
            ],
          ),
        ],
      ),
    );
  }

  /// Category filter chips for music genres
  Widget _buildCategoryFilter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Browse by Category',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final isSelected = index == _selectedCategoryIndex;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(_categories[index]),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategoryIndex = selected ? index : 0;
                    });
                  },
                  backgroundColor: Colors.grey[200],
                  selectedColor:
                      Theme.of(context).primaryColor.withOpacity(0.2),
                  labelStyle: TextStyle(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey[700],
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Featured playlists section with horizontal scrolling
  Widget _buildFeaturedPlaylists(BuildContext context, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Playlists',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () => _showAllPlaylists(context),
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: isTablet ? 280 : 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _featuredPlaylists.length,
            itemBuilder: (context, index) {
              final playlist = _featuredPlaylists[index];
              return Container(
                width: isTablet ? 200 : 160,
                margin: const EdgeInsets.only(right: 16),
                child: _PlaylistCard(
                  title: playlist['title'],
                  subtitle: playlist['subtitle'],
                  imageUrl: playlist['imageUrl'],
                  color: playlist['color'],
                  onTap: () => _onPlaylistTap(playlist),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Recently played tracks section
  Widget _buildRecentTracks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recently Played',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () => _showAllTracks(context),
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentTracks.length,
          itemBuilder: (context, index) {
            final track = _recentTracks[index];
            return _TrackListItem(
              title: track['title'],
              artist: track['artist'],
              duration: track['duration'],
              imageUrl: track['imageUrl'],
              onTap: () => _onTrackTap(track),
              onPlay: () => _onTrackPlay(track),
            );
          },
        ),
      ],
    );
  }

  /// Floating action button for quick actions
  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _showQuickActions(context),
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      icon: const Icon(Icons.add),
      label: const Text('Add Music'),
      elevation: 4,
    );
  }

  /// Bottom navigation bar (placeholder)
  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', true),
          _buildNavItem(Icons.search, 'Search', false),
          _buildNavItem(Icons.library_music, 'Library', false),
          _buildNavItem(Icons.person, 'Profile', false),
        ],
      ),
    );
  }

  /// Helper method to get time-based greeting
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }

  /// Helper method to build stat cards
  Widget _buildStatCard(BuildContext context, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method to build navigation items
  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
          ),
        ),
      ],
    );
  }

  // Event handlers - these would connect to your actual business logic
  Future<void> _onRefresh() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      // Refresh data here
    });
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Music'),
        content: const Text('Search functionality coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No new notifications')),
    );
  }

  void _showAllPlaylists(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All playlists view coming soon!')),
    );
  }

  void _showAllTracks(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All tracks view coming soon!')),
    );
  }

  void _showQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.upload),
              title: const Text('Upload Music'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.playlist_add),
              title: const Text('Create Playlist'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Add to Favorites'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _onPlaylistTap(Map<String, dynamic> playlist) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening ${playlist['title']}')),
    );
  }

  void _onTrackTap(Map<String, dynamic> track) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Playing ${track['title']}')),
    );
  }

  void _onTrackPlay(Map<String, dynamic> track) {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isPlaying ? 'Playing ${track['title']}' : 'Paused'),
      ),
    );
  }
}

/// Custom widget for playlist cards
/// Demonstrates widget composition and reusability
class _PlaylistCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Color color;
  final VoidCallback onTap;

  const _PlaylistCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Playlist image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.3),
                ),
                child: Stack(
                  children: [
                    // Placeholder image (in real app, use actual images)
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0.6),
                            color.withOpacity(0.3)
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.music_note,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    // Play button overlay
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          size: 20,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Playlist info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom widget for track list items
/// Shows how to create reusable list item components
class _TrackListItem extends StatelessWidget {
  final String title;
  final String artist;
  final String duration;
  final String imageUrl;
  final VoidCallback onTap;
  final VoidCallback onPlay;

  const _TrackListItem({
    required this.title,
    required this.artist,
    required this.duration,
    required this.imageUrl,
    required this.onTap,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
          ),
          child: const Icon(
            Icons.music_note,
            color: Colors.grey,
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        artist,
        style: TextStyle(color: Colors.grey[600]),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            duration,
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: onPlay,
            icon: const Icon(Icons.play_circle_outline),
            iconSize: 32,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
