// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:groovix/core/theme/app_theme.dart';

/// ExploreScreen - Figma-inspired UI only (no logic)
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        backgroundColor: ThemeColors.primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ThemeColors.primaryColor.withOpacity(0.1),
              ThemeColors.white,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Search bar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.primaryColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search music, artists, albums...',
                  hintStyle: const TextStyle(color: ThemeColors.grey),
                  prefixIcon: const Icon(Icons.search, color: ThemeColors.primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: ThemeColors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Trending section
            Text('Trending',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold, color: ThemeColors.black)),
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
                        color: ThemeColors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: ThemeColors.primaryColor.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.trending_up,
                              size: 40, color: ThemeColors.primaryColor),
                          const SizedBox(height: 8),
                          Text('Song ${i + 1}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.black)),
                          const Text('Artist',
                              style: TextStyle(color: ThemeColors.grey)),
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
                    ?.copyWith(fontWeight: FontWeight.bold, color: ThemeColors.black)),
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
                  Container(
                    decoration: BoxDecoration(
                      color: ThemeColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: ThemeColors.primaryColor.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Chip(
                      label: Text(genre),
                      backgroundColor: Colors.transparent,
                      labelStyle: const TextStyle(color: ThemeColors.primaryColor, fontWeight: FontWeight.w500),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
