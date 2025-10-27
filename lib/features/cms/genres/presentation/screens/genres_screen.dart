import 'package:groovix/features/cms/cms_index.dart';
import 'package:groovix/core/models/genre_model.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    context
        .read<CmsGenreBloc>()
        .add(FetchGenresList(GenresQueryModel(page: 1, size: 100)));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refetch genres when screen becomes visible again
    if (ModalRoute.of(context)?.isCurrent == true) {
      context
          .read<CmsGenreBloc>()
          .add(FetchGenresList(GenresQueryModel(page: 1, size: 100)));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? ThemeColors.darkAppColor : ThemeColors.white,
      appBar: AppBar(
        title: const Text('Genres'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          SearchBar(
              placeholder: 'Search genres by name...',
              controller: _searchController,
              onChanged: (value) {
                _isSearching = true;
              },
              onSearch: (query) {
                _isSearching = false;
                getIt<CmsGenreBloc>().add(SearchGenres(query));
              },
              onClear: _isSearching
                  ? () {}
                  : () {
                      getIt<CmsGenreBloc>().add(FetchGenresList(
                          GenresQueryModel(page: 1, size: 100)));
                    }),

          // Genres List
          Expanded(
            child: BlocListener<CmsGenreBloc, CmsGenreState>(
              listener: (context, state) {
                if (state is CreateGenreLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${state.genre.name} created successfully'),
                      backgroundColor: ThemeColors.clrGreen,
                    ),
                  );
                  Navigator.pop(context);
                  getIt<CmsGenreBloc>().add(
                      FetchGenresList(GenresQueryModel(page: 1, size: 100)));
                } else if (state is UpdateGenreLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${state.genre.name} updated successfully'),
                      backgroundColor: ThemeColors.clrGreen,
                    ),
                  );
                  Navigator.pop(context);
                } else if (state is GenreDeletedSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Genre deleted successfully'),
                      backgroundColor: ThemeColors.clrGreen,
                    ),
                  );
                  getIt<CmsGenreBloc>().add(
                      FetchGenresList(GenresQueryModel(page: 1, size: 100)));
                } else if (state is CreateGenreError ||
                    state is UpdateGenreError ||
                    state is GenreDeletedError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          (state as dynamic).message ?? 'An error occurred'),
                      backgroundColor: ThemeColors.red,
                    ),
                  );
                }
              },
              child: BlocBuilder<CmsGenreBloc, CmsGenreState>(
                builder: (context, state) {
                  if (state is CmsGenreLoading || state is DeleteGenreLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: ThemeColors.primaryColor));
                  }
                  if (state is CmsGenreError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 64,
                            color: ThemeColors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error loading genres',
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.message,
                            style: theme.textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              getIt<CmsGenreBloc>().add(FetchGenresList(
                                  GenresQueryModel(page: 1, size: 100)));
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is CmsGenreLoaded) {
                    return _buildGenresList(context, state.genres);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "cms_genres_fab",
        onPressed: _navigateToAddGenre,
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGenresList(BuildContext context, List<GenreModel> genres) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (genres.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category_outlined,
              size: 64,
              color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
            ),
            const SizedBox(height: 16),
            Text(
              'No genres found',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first genre to get started',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: genres.length,
      itemBuilder: (context, index) {
        final genre = genres[index];
        return _buildGenreCard(context, genre);
      },
    );
  }

  Widget _buildGenreCard(BuildContext context, GenreModel genre) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: genre.coverUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(genre.coverUrl),
                    fit: BoxFit.cover,
                  )
                : null,
            color: genre.coverUrl.isEmpty
                ? ThemeColors.primaryColor.withOpacity(0.1)
                : null,
          ),
          child: genre.coverUrl.isEmpty
              ? const Icon(
                  Icons.category,
                  color: ThemeColors.primaryColor,
                  size: 24,
                )
              : null,
        ),
        title: Text(
          genre.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? ThemeColors.white : ThemeColors.black,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          genre.bio,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
          ),
          onSelected: (value) {
            switch (value) {
              case 'add_songs':
                _navigateToAddSongs(genre);
                break;
              case 'edit':
                _navigateToEditGenre(genre);
                break;
              case 'delete':
                _showDeleteConfirmation(context, genre);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'add_songs',
              child: Row(
                children: [
                  Icon(Icons.add_circle_outline,
                      color: ThemeColors.primaryColor),
                  SizedBox(width: 8),
                  Text('Add Songs'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, color: ThemeColors.primaryColor),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete_outline, color: ThemeColors.red),
                  SizedBox(width: 8),
                  Text('Delete'),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          _navigateToGenreSongs(genre);
        },
      ),
    );
  }

  void _navigateToAddGenre() {
    context.push(AppRoutes.addGenre);
  }

  void _navigateToAddSongs(GenreModel genre) {
    context.push(AppRoutes.addSongsToGenre, extra: genre);
  }

  void _navigateToEditGenre(GenreModel genre) {
    context.push(AppRoutes.editGenre, extra: genre);
  }

  void _navigateToGenreSongs(GenreModel genre) {
    context.push(AppRoutes.genreSongs, extra: genre);
  }

  void _showDeleteConfirmation(BuildContext context, GenreModel genre) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Genre'),
        content: Text('Are you sure you want to delete "${genre.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              getIt<CmsGenreBloc>().add(DeleteGenre(genre.id));
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.pop(context);
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
