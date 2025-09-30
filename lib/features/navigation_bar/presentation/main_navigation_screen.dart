// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:groovix/features/explore/presentation/explore_screen.dart';
import 'package:groovix/features/home/presentation/home_screen.dart';
import 'package:groovix/features/library/presentation/library_screen.dart';
import 'package:groovix/features/navigation_bar/presentation/navigation_bar.dart';
import 'package:groovix/features/playlist/presentation/playlist_screen.dart';
import 'package:groovix/features/settings/presentation/settings_screen.dart';
import 'package:groovix/features/song/presentation/upload_song.dart';

/// MainNavigationScreen - Main screen with bottom navigation
/// This screen manages navigation between different sections of the app
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // List of screens to display based on navigation index
  final List<Widget> _screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const UploadSongScreen(),
    const PlaylistScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: GroovixBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
