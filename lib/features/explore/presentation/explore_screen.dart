// ignore_for_file: prefer_final_fields

import 'package:groovix/features/cms/shared/widgets/search_bar.dart' as search;
import '../../../routes/routes_index.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _searchController = TextEditingController();
  ValueNotifier<bool> _isSearching = ValueNotifier(false);
  int _currentPage = 1;
  int _pageSize = 10;

  @override
  initState() {
    super.initState();
    defaultCall();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void paginationCall() {
    getIt<SongCubit>()
        .getSongList(SongsQueryModel(page: _currentPage, size: _pageSize));
  }

  void defaultCall() {
    getIt<SongCubit>().getSongList(SongsQueryModel(page: 1, size: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
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
        child: Column(
          children: [
            search.SearchBar(
                placeholder: 'Search songs by name, artist, or album...',
                controller: _searchController,
                onSearch: (query) {
                  if (_searchController.text.isNotEmpty) {
                    _isSearching.value = true;
                    getIt<SongCubit>().onSearchSongs(query);
                  } else if (_searchController.text.isEmpty) {
                    _isSearching.value = false;
                    getIt<SongCubit>().clearSearchSongs();
                  }
                  setState(() {});
                },
                onClear: () {
                  _isSearching.value = false;
                  getIt<SongCubit>().clearSearchSongs();
                  setState(() {});
                }),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: _isSearching,
                  builder: (context, isSearching, _) {
                    return BlocConsumer<SongCubit, SongState>(
                      listener: (context, state) {
                        if (state.songsListResponse?.songs != null) {
                          _currentPage++;
                          _pageSize++;
                        }
                      },
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state.error != null) {
                          return Center(child: Text(state.error!));
                        }
                        if (isSearching && state.searchSongs != null) {
                          final songs = state.searchSongs!;
                          return _buildSongsList(songs);
                        }
                        if (!isSearching && state.songsListResponse != null) {
                          final songs = state.songsListResponse!.songs;
                          return _buildSongsList(songs);
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSongsList(List<SongModel> songs) {
    if (songs.isEmpty) {
      return const Center(child: Text('No songs found'));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return SongListTile(songs: songs, currentIndex: index);
      },
    );
  }
}
