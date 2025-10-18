import 'cms_index.dart';

class CMSScreen extends StatefulWidget {
  const CMSScreen({super.key});

  @override
  State<CMSScreen> createState() => _CMSScreenState();
}

class _CMSScreenState extends State<CMSScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const CMSSongsScreen(),
    const CMSArtistsScreen(),
    const PlaylistsScreen(),
    const GenresScreen(),
    const CMSSettingsScreen(),
  ];

  final List<BottomNavigationBarItem> _navItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.dashboard_outlined),
      activeIcon: Icon(Icons.dashboard),
      label: 'CMS',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.music_note_outlined),
      activeIcon: Icon(Icons.music_note),
      label: 'Songs',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outlined),
      activeIcon: Icon(Icons.person),
      label: 'Artists',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.queue_music_outlined),
      activeIcon: Icon(Icons.queue_music),
      label: 'Playlists',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.category_outlined),
      activeIcon: Icon(Icons.category),
      label: 'Genres',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      activeIcon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (context) => getIt<DashboardBloc>(),
        ),
        BlocProvider<CmsSongBloc>(
          create: (context) => getIt<CmsSongBloc>(),
        ),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: SafeArea(
            child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            selectedItemColor: ThemeColors.primaryColor,
            unselectedItemColor:
                isDark ? ThemeColors.white70 : ThemeColors.grey600,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: ThemeFonts.lexend,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: ThemeFonts.lexend,
            ),
            items: _navItems,
          ),
        )),
      ),
    );
  }
}
