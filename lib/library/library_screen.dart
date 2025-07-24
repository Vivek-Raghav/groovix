import 'package:flutter/material.dart';

/// LibraryScreen - Figma-inspired UI only (no logic)
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Liked Songs
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.deepPurple[50],
            child: ListTile(
              leading: Icon(Icons.favorite, color: Colors.pink, size: 32),
              title: const Text('Liked Songs',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Your favorite tracks'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 24),
          // Downloaded Albums
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.deepPurple[50],
            child: ListTile(
              leading: Icon(Icons.download, color: Colors.blue, size: 32),
              title: const Text('Downloads',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Offline albums & tracks'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
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
                backgroundColor: Colors.deepPurple[100],
                child: Icon(Icons.music_note, color: Colors.deepPurple),
              ),
              title: Text('Track ${i + 1}'),
              subtitle: const Text('Artist Name'),
              trailing: Icon(Icons.play_arrow, color: Colors.deepPurple),
              onTap: () {},
            ),
        ],
      ),
    );
  }
}
