// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:groovix/core/theme/app_theme.dart';

/// PlaylistScreen - Figma-inspired UI only (no logic)
class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Playlists'),
        backgroundColor: ThemeColors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Create Playlist Button
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Create New Playlist'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColors.deepPurple,
              foregroundColor: ThemeColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 24),
          // Playlist Cards
          for (int i = 0; i < 4; i++)
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: ThemeColors.deepPurple50,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: ThemeColors.deepPurple100,
                  child: Icon(Icons.album, color: ThemeColors.deepPurple),
                ),
                title: Text('Playlist ${i + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('X songs'),
                trailing: const Icon(Icons.arrow_forward_ios,
                    color: ThemeColors.deepPurple),
                onTap: () {},
              ),
            ),
        ],
      ),
    );
  }
}
