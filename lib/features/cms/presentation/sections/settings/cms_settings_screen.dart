import 'package:groovix/features/auth/bloc/auth_bloc.dart';
import 'package:groovix/features/auth/bloc/auth_events.dart';
import 'package:groovix/routes/routes_index.dart';

class CMSSettingsScreen extends StatefulWidget {
  const CMSSettingsScreen({super.key});

  @override
  State<CMSSettingsScreen> createState() => _CMSSettingsScreenState();
}

class _CMSSettingsScreenState extends State<CMSSettingsScreen> {
  final ThemeManager _themeManager = ThemeManager();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _themeManager.initializeTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeManager,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            backgroundColor: ThemeColors.primaryColor,
            foregroundColor: ThemeColors.white,
            elevation: 0,
            centerTitle: true,
          ),
          body: _buildSettingsList(context),
        );
      },
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Appearance Section
        _buildSectionHeader(context, 'Appearance'),
        AnimatedBuilder(
          animation: _themeManager,
          builder: (context, child) {
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(_themeManager.themeModeIcon,
                    color: Theme.of(context).colorScheme.primary, size: 20),
              ),
              title: Text('Theme',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w500)),
              subtitle: Text(
                _themeManager.themeModeDisplayName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary, size: 16),
              onTap: () => _showThemeSelectionDialog(),
            );
          },
        ),

        const SizedBox(height: 24),

        // Account Section
        _buildSectionHeader(context, 'Account'),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ListTile(
                leading:
                    const Icon(Icons.person, color: ThemeColors.primaryColor),
                title: const Text('Profile'),
                subtitle: const Text('Manage your profile information'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to profile screen
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading:
                    const Icon(Icons.security, color: ThemeColors.primaryColor),
                title: const Text('Privacy & Security'),
                subtitle: const Text('Manage your privacy settings'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to privacy screen
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.help_outline,
                    color: ThemeColors.primaryColor),
                title: const Text('Help & Support'),
                subtitle: const Text('Get help and contact support'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to help screen
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // About Section
        _buildSectionHeader(context, 'About'),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.info_outline,
                    color: ThemeColors.primaryColor),
                title: const Text('About Groovix CMS'),
                subtitle: const Text('Version 1.0.0'),
                onTap: () {
                  _showAboutDialog(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.star_outline,
                    color: ThemeColors.primaryColor),
                title: const Text('Rate App'),
                subtitle: const Text('Rate us on the app store'),
                onTap: () {
                  // Open app store rating
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Logout Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              _showLogoutConfirmation(context);
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColors.red,
              foregroundColor: ThemeColors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
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

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Groovix CMS',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: ThemeColors.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.music_note,
          color: ThemeColors.white,
          size: 32,
        ),
      ),
      children: [
        const Text(
            'A comprehensive content management system for managing music content.'),
      ],
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final auth = getIt<AuthBloc>();
              auth.add(AuthLogoutEvent());
              Navigator.pop(context);
              context.go(AppRoutes.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColors.red,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
