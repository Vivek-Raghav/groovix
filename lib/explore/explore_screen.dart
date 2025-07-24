import 'package:flutter/material.dart';

/// ExploreScreen - Figma-inspired UI only (no logic)
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search music, artists, albums...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.deepPurple[50],
            ),
          ),
          const SizedBox(height: 24),
          // Trending section
          Text('Trending',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (int i = 0; i < 4; i++)
                  Container(
                    width: 120,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.trending_up,
                            size: 40, color: Colors.deepPurple),
                        const SizedBox(height: 8),
                        Text('Song ${i + 1}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const Text('Artist',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Genres section
          Text('Genres',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final genre in [
                'Pop',
                'Rock',
                'Hip-Hop',
                'Jazz',
                'Classical',
                'EDM',
                'Indie'
              ])
                Chip(
                  label: Text(genre),
                  backgroundColor: Colors.deepPurple[50],
                  labelStyle: const TextStyle(color: Colors.deepPurple),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
