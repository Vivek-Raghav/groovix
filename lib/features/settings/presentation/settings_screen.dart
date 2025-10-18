import 'package:groovix/features/auth/auth_index.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ThemeManager _themeManager = ThemeManager();

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
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.1),
                Theme.of(context).colorScheme.background,
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
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(Icons.person,
                            size: 48,
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      const SizedBox(height: 12),
                      Text('Your Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onSurface)),
                      Text("${cache.getMap(PrefKeys.userDetails)?['email']}",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Account settings
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
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
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.edit,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20),
                      ),
                      title: Text('Edit Profile',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500)),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primary,
                          size: 16),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.lock,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20),
                      ),
                      title: Text('Change Password',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500)),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primary,
                          size: 16),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.notifications,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20),
                      ),
                      title: Text('Notifications',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500)),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primary,
                          size: 16),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // App settings
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _themeManager,
                      builder: (context, child) {
                        return ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(_themeManager.themeModeIcon,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20),
                          ),
                          title: Text('Theme',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.w500)),
                          subtitle: Text(
                            _themeManager.themeModeDisplayName,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.primary,
                              size: 16),
                          onTap: () => _showThemeSelectionDialog(),
                        );
                      },
                    ),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.language,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20),
                      ),
                      title: Text('Language',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500)),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primary,
                          size: 16),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.info,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20),
                      ),
                      title: Text('About Groovix',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500)),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primary,
                          size: 16),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Logout
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Theme.of(context).colorScheme.error.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.logout,
                        color: Theme.of(context).colorScheme.error, size: 20),
                  ),
                  title: Text('Logout',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontWeight: FontWeight.w500)),
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

  void _showThemeSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            'Choose Theme',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildThemeOption(
                context,
                'Light',
                Icons.light_mode,
                ThemeMode.light,
                'Always use light theme',
              ),
              const SizedBox(height: 8),
              _buildThemeOption(
                context,
                'Dark',
                Icons.dark_mode,
                ThemeMode.dark,
                'Always use dark theme',
              ),
              const SizedBox(height: 8),
              _buildThemeOption(
                context,
                'System',
                Icons.brightness_auto,
                ThemeMode.system,
                'Follow system setting',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String title,
    IconData icon,
    ThemeMode mode,
    String subtitle,
  ) {
    final isSelected = _themeManager.themeMode == mode;

    return AnimatedBuilder(
      animation: _themeManager,
      builder: (context, child) {
        return ListTile(
          leading: Icon(
            icon,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurfaceVariant,
            size: 24,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Lexend',
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          trailing: isSelected
              ? Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                )
              : null,
          onTap: () async {
            await _themeManager.setThemeMode(mode);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
