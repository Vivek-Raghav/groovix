// Project imports:
import 'package:groovix/core/constants/size_const.dart';
import 'package:groovix/features/auth/auth_index.dart';
import 'package:groovix/features/cms/genres/domain/models/genres_query_model.dart';
import 'package:groovix/features/cms/genres/presentation/bloc/cms_genre_bloc.dart';
import 'package:groovix/features/cms/genres/presentation/bloc/cms_genre_event.dart';
import 'package:groovix/features/cms/genres/presentation/bloc/cms_genre_state.dart';
import 'package:groovix/features/home/presentation/widgets/genre_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final songCubit = getIt<SongCubit>();
  int currentPage = 1;
  int pageSize = 10;

  @override
  void initState() {
    super.initState();
    initCalls();
  }

  void initCalls() {
    songCubit.getSongList(SongsQueryModel(page: currentPage, size: pageSize));
    getIt<CmsGenreBloc>()
        .add(FetchGenresList(GenresQueryModel(page: 1, size: 100)));
    getIt<PlaylistBloc>()
        .add(FetchPlaylistsList(PlaylistsQueryModel(page: 1, size: 100)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.headphones,
                    size: 48, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome to Groovix!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onSurface)),
                      const SizedBox(height: 4),
                      Text('Discover and enjoy your favorite music.',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          BlocBuilder<CmsGenreBloc, CmsGenreState>(builder: (context, state) {
            if (state is CmsGenreLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ThemeColors.primaryColor,
                ),
              );
            } else if (state is CmsGenreLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Genres',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: state.genres
                        .map((e) => GestureDetector(
                            onTap: () {
                              getIt<CmsGenreBloc>().add(FetchGenreSongs(e.id));
                              context.push(AppRoutes.songListScreen,
                                  extra: SongListContext.genre.name);
                            },
                            child: GenreCard(genre: e)))
                        .toList(),
                  )
                ],
              );
            }
            return const SizedBox.shrink();
          }),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (int i = 0; i < 3; i++)
                  Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.album,
                            size: 48,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(height: 12),
                        Text('Playlist ${i + 1}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onSurface)),
                        Text('Subtitle',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text('Recently Played',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          BlocBuilder<SongCubit, SongState>(builder: (context, state) {
            if (state is SongListSuccess) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.songsListResponse.songs.length,
                itemBuilder: (context, index) {
                  final songs = state.songsListResponse.songs;
                  return SongListTile(songs: songs, currentIndex: index);
                },
              );
            } else if (state is SongListLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SizedBox.shrink();
          }),
          hMiniMusic
        ],
      ),
    );
  }

// AppBar build
  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.music_note,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Groovix',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.notifications_none,
                color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () {}),
      ],
    );
  }
}
