import 'package:groovix/features/navigation_bar/navigation_index.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key, this.index = 0});
  final int? index;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index ?? 0;
  }

  // List of screens to display based on navigation index
  final List<Widget> _screens = [
    const HomePage(),
    const ExploreScreen(),
    const UploadSongScreen(),
    const PlaylistScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: GroovixBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
