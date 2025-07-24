// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:groovix/core/theme/app_theme.dart';
import 'package:groovix/routes/app_routes.dart';

/// SettingsScreen - Figma-inspired UI only (no logic)
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: ThemeColors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Profile section
          const Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: ThemeColors.deepPurple100,
                  child: Icon(Icons.person,
                      size: 48, color: ThemeColors.deepPurple),
                ),
                SizedBox(height: 12),
                Text('Your Name',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text('user@email.com',
                    style: TextStyle(color: ThemeColors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Account settings
          ListTile(
            leading: const Icon(Icons.edit, color: ThemeColors.deepPurple),
            title: const Text('Edit Profile'),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: ThemeColors.deepPurple),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.lock, color: ThemeColors.deepPurple),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: ThemeColors.deepPurple),
            onTap: () {},
          ),
          ListTile(
            leading:
                const Icon(Icons.notifications, color: ThemeColors.deepPurple),
            title: const Text('Notifications'),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: ThemeColors.deepPurple),
            onTap: () {},
          ),
          const Divider(height: 32),
          // App settings
          ListTile(
            leading: const Icon(Icons.palette, color: ThemeColors.deepPurple),
            title: const Text('Theme'),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: ThemeColors.deepPurple),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.language, color: ThemeColors.deepPurple),
            title: const Text('Language'),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: ThemeColors.deepPurple),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info, color: ThemeColors.deepPurple),
            title: const Text('About Groovix'),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: ThemeColors.deepPurple),
            onTap: () {},
          ),
          const Divider(height: 32),
          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: ThemeColors.red),
            title:
                const Text('Logout', style: TextStyle(color: ThemeColors.red)),
            onTap: () {
              context.push(AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }
}
