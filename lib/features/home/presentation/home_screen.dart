// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:groovix/core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeColors.primaryColor,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ThemeColors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.music_note, 
                color: ThemeColors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Groovix',
              style: TextStyle(
                color: ThemeColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: ThemeColors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: ThemeColors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Welcome Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.deepPurple[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.headphones, size: 48, color: Colors.deepPurple),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome to Groovix!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 4),
                      Text('Discover and enjoy your favorite music.',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Category Chips (horizontal)
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final cat in [
                  'All',
                  'Pop',
                  'Rock',
                  'Hip-Hop',
                  'Jazz',
                  'Classical'
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Chip(
                      label: Text(cat),
                      backgroundColor:
                          cat == 'All' ? Colors.deepPurple : Colors.grey[200],
                      labelStyle: TextStyle(
                          color: cat == 'All' ? Colors.white : Colors.black),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (int i = 0; i < 3; i++)
                  Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.album,
                            size: 48, color: Colors.deepPurple),
                        const SizedBox(height: 12),
                        Text('Playlist ${i + 1}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const Text('Subtitle',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text('Recently Played',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          for (int i = 0; i < 4; i++)
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple[100],
                child: const Icon(Icons.music_note, color: Colors.deepPurple),
              ),
              title: Text('Track ${i + 1}'),
              subtitle: const Text('Artist Name'),
              trailing: const Icon(Icons.play_arrow, color: Colors.deepPurple),
              onTap: () {},
            ),
        ],
      ),
    );
  }
}
