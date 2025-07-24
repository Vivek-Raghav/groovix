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
        backgroundColor: ThemeColors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: ThemeColors.grey200,
              child:
                  const Icon(Icons.music_note, color: ThemeColors.deepPurple),
            ),
            const SizedBox(width: 12),
            const Text(
              'Groovix',
              style: TextStyle(
                color: ThemeColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: ThemeColors.black),
            onPressed: () {},
          ),
          IconButton(
            icon:
                const Icon(Icons.notifications_none, color: ThemeColors.black),
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
              color: ThemeColors.deepPurple50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.headphones, size: 48, color: ThemeColors.deepPurple),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Welcome to Groovix!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 4),
                      Text('Discover and enjoy your favorite music.',
                          style: TextStyle(color: ThemeColors.grey)),
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
                      backgroundColor: cat == 'All'
                          ? ThemeColors.deepPurple
                          : ThemeColors.grey200,
                      labelStyle: TextStyle(
                          color: cat == 'All'
                              ? ThemeColors.white
                              : ThemeColors.black),
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
                      color: ThemeColors.deepPurple100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.album,
                            size: 48, color: ThemeColors.deepPurple),
                        const SizedBox(height: 12),
                        Text('Playlist ${i + 1}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const Text('Subtitle',
                            style: TextStyle(color: ThemeColors.grey)),
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
                backgroundColor: ThemeColors.deepPurple100,
                child:
                    const Icon(Icons.music_note, color: ThemeColors.deepPurple),
              ),
              title: Text('Track ${i + 1}'),
              subtitle: const Text('Artist Name'),
              trailing:
                  const Icon(Icons.play_arrow, color: ThemeColors.deepPurple),
              onTap: () {},
            ),
        ],
      ),
    );
  }
}
