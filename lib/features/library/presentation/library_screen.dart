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
            // Liked Songs
            Container(
              decoration: BoxDecoration(
                color: ThemeColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.primaryColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ThemeColors.pink.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.favorite, color: ThemeColors.pink, size: 24),
                ),
                title: const Text('Liked Songs',
                    style: TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.black)),
                subtitle: const Text('Your favorite tracks', style: TextStyle(color: ThemeColors.grey)),
                trailing: const Icon(Icons.arrow_forward_ios, color: ThemeColors.primaryColor),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 24),
            // Downloaded Albums
            Container(
              decoration: BoxDecoration(
                color: ThemeColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.primaryColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ThemeColors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.download, color: ThemeColors.blue, size: 24),
                ),
                title: const Text('Downloads',
                    style: TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.black)),
                subtitle: const Text('Offline albums & tracks', style: TextStyle(color: ThemeColors.grey)),
                trailing: const Icon(Icons.arrow_forward_ios, color: ThemeColors.primaryColor),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 32),
            // Recently Played section
            Text('Recently Played',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold, color: ThemeColors.black)),
            const SizedBox(height: 16),
            for (int i = 0; i < 3; i++)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: ThemeColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.primaryColor.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ThemeColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.music_note, color: ThemeColors.primaryColor, size: 20),
                  ),
                  title: Text('Track ${i + 1}', style: const TextStyle(fontWeight: FontWeight.w600, color: ThemeColors.black)),
                  subtitle: const Text('Artist Name', style: TextStyle(color: ThemeColors.grey)),
                  trailing: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ThemeColors.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.play_arrow, color: ThemeColors.white, size: 20),
                  ),
                  onTap: () {},
                ),
              ),
          ],
        ),
      ),
    );
  }
}
