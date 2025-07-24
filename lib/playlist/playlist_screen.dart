import 'package:flutter/material.dart';

/// PlaylistScreen - Figma-inspired UI only (no logic)
class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Playlists'),
        backgroundColor: Colors.deepPurple,
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
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
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
              color: Colors.deepPurple[50],
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple[100],
                  child: Icon(Icons.album, color: Colors.deepPurple),
                ),
                title: Text('Playlist ${i + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('X songs'),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                onTap: () {},
              ),
            ),
        ],
      ),
    );
  }
}
