import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:groovix/routes/app_routes.dart';
import 'package:groovix/auth/login_screen.dart';
import 'package:groovix/auth/signup_screen.dart';

/// SettingsScreen - Figma-inspired UI only (no logic)
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Profile section
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.deepPurple[100],
                  child: const Icon(Icons.person,
                      size: 48, color: Colors.deepPurple),
                ),
                const SizedBox(height: 12),
                const Text('Your Name',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const Text('user@email.com',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Account settings
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.deepPurple),
            title: const Text('Edit Profile'),
            trailing:
                const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.deepPurple),
            title: const Text('Change Password'),
            trailing:
                const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.deepPurple),
            title: const Text('Notifications'),
            trailing:
                const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
            onTap: () {},
          ),
          const Divider(height: 32),
          // App settings
          ListTile(
            leading: const Icon(Icons.palette, color: Colors.deepPurple),
            title: const Text('Theme'),
            trailing:
                const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.language, color: Colors.deepPurple),
            title: const Text('Language'),
            trailing:
                const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.deepPurple),
            title: const Text('About Groovix'),
            trailing:
                const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
            onTap: () {},
          ),
          const Divider(height: 32),
          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              context.push(AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }
}
