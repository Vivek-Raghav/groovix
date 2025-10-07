// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:groovix/core/shared/domain/method/methods.dart';
import 'package:groovix/core/theme/app_theme.dart';
import 'package:groovix/features/auth/auth_index.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cache = getIt<LocalCache>();
    return BlocListener<AuthBloc, AuthState>(
      bloc: getIt<AuthBloc>(),
      listener: (context, state) {
        if (state is AuthLogoutSuccess) {
          debugPrint('Logout success');
          context.go(AppRoutes.login);
        } else if (state is AuthLogoutFailure) {
          showToast(title: state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
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
              // Profile section
              Container(
                padding: const EdgeInsets.all(24),
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
                child: Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: ThemeColors.primaryColor,
                        child: Icon(Icons.person,
                            size: 48, color: ThemeColors.white),
                      ),
                      const SizedBox(height: 12),
                      const Text('Your Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: ThemeColors.black)),
                      Text("${cache.getMap(PrefKeys.userDetails)?['email']}",
                          style: const TextStyle(color: ThemeColors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Account settings
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
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ThemeColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.edit,
                            color: ThemeColors.primaryColor, size: 20),
                      ),
                      title: const Text('Edit Profile',
                          style: TextStyle(
                              color: ThemeColors.black,
                              fontWeight: FontWeight.w500)),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: ThemeColors.primaryColor, size: 16),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ThemeColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.lock,
                            color: ThemeColors.primaryColor, size: 20),
                      ),
                      title: const Text('Change Password',
                          style: TextStyle(
                              color: ThemeColors.black,
                              fontWeight: FontWeight.w500)),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: ThemeColors.primaryColor, size: 16),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ThemeColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.notifications,
                            color: ThemeColors.primaryColor, size: 20),
                      ),
                      title: const Text('Notifications',
                          style: TextStyle(
                              color: ThemeColors.black,
                              fontWeight: FontWeight.w500)),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: ThemeColors.primaryColor, size: 16),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // App settings
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
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ThemeColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.palette,
                            color: ThemeColors.primaryColor, size: 20),
                      ),
                      title: const Text('Theme',
                          style: TextStyle(
                              color: ThemeColors.black,
                              fontWeight: FontWeight.w500)),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: ThemeColors.primaryColor, size: 16),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ThemeColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.language,
                            color: ThemeColors.primaryColor, size: 20),
                      ),
                      title: const Text('Language',
                          style: TextStyle(
                              color: ThemeColors.black,
                              fontWeight: FontWeight.w500)),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: ThemeColors.primaryColor, size: 16),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ThemeColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.info,
                            color: ThemeColors.primaryColor, size: 20),
                      ),
                      title: const Text('About Groovix',
                          style: TextStyle(
                              color: ThemeColors.black,
                              fontWeight: FontWeight.w500)),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: ThemeColors.primaryColor, size: 16),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Logout
              Container(
                decoration: BoxDecoration(
                  color: ThemeColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.red.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ThemeColors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.logout,
                        color: ThemeColors.red, size: 20),
                  ),
                  title: const Text('Logout',
                      style: TextStyle(
                          color: ThemeColors.red, fontWeight: FontWeight.w500)),
                  onTap: () async {
                    getIt<AuthBloc>().add(AuthLogoutEvent());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
