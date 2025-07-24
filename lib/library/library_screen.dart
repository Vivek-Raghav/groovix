// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:groovix/core/theme/app_theme.dart';

/// LibraryScreen - Figma-inspired UI only (no logic)
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        backgroundColor: ThemeColors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Liked Songs
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: ThemeColors.deepPurple50,
            child: ListTile(
              leading: Icon(Icons.favorite, color: ThemeColors.pink, size: 32),
              title: const Text('Liked Songs',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Your favorite tracks'),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: ThemeColors.deepPurple),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 24),
          // Downloaded Albums
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: ThemeColors.deepPurple50,
            child: ListTile(
              leading: Icon(Icons.download, color: ThemeColors.blue, size: 32),
              title: const Text('Downloads',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Offline albums & tracks'),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: ThemeColors.deepPurple),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 24),
          // Recently Played
          Text('Recently Played',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          for (int i = 0; i < 3; i++)
            ListTile(
              leading: CircleAvatar(
                backgroundColor: ThemeColors.deepPurple100,
                child: Icon(Icons.music_note, color: ThemeColors.deepPurple),
              ),
              title: Text('Track ${i + 1}'),
              subtitle: const Text('Artist Name'),
              trailing: Icon(Icons.play_arrow, color: ThemeColors.deepPurple),
              onTap: () {},
            ),
        ],
      ),
    );
  }
}
