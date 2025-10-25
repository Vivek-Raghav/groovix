// Project imports:
// ignore_for_file: unnecessary_null_comparison

import "package:groovix/features/cms/cms_index.dart";

class CMSArtistsScreen extends StatefulWidget {
  const CMSArtistsScreen({super.key});

  @override
  State<CMSArtistsScreen> createState() => _CMSArtistsScreenState();
}

class _CMSArtistsScreenState extends State<CMSArtistsScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    context
        .read<CmsArtistBloc>()
        .add(FetchArtistsList(ArtistsQueryModel(page: 1, size: 100)));
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
        title: const Text('Artists'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          SearchBar(
              placeholder: 'Search artists by name...',
              controller: _searchController,
              onChanged: (value) {
                _isSearching = true;
              },
              onSearch: (query) {
                _isSearching = false;
                context.read<CmsArtistBloc>().add(SearchArtists(query));
              },
              onClear: _isSearching
                  ? () {}
                  : () {
                      context.read<CmsArtistBloc>().add(FetchArtistsList(
                          ArtistsQueryModel(page: 1, size: 100)));
                    }),

          // Artists List
          Expanded(
            child: BlocBuilder<CmsArtistBloc, CmsArtistState>(
              builder: (context, state) {
                if (state is CmsArtistLoading ||
                    state is ArtistDeletedLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: ThemeColors.primaryColor));
                }
                if (state is CmsArtistError) {
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
                          'Error loading artists',
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
                            context.read<CmsArtistBloc>().add(FetchArtistsList(
                                ArtistsQueryModel(page: 1, size: 100)));
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                if (state is CmsArtistLoaded) {
                  return _buildArtistsList(context, state.artists);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "cms_artists_fab",
        onPressed: () {
          context.push(AppRoutes.addArtist);
        },
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildArtistsList(BuildContext context, List<ArtistModel> artists) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (artists.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_off,
              size: 64,
              color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
            ),
            const SizedBox(height: 16),
            Text(
              'No artists found',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first artist to get started',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: artists.length,
      itemBuilder: (context, index) {
        final artist = artists[index];
        return _buildArtistCard(context, artist);
      },
    );
  }

  Widget _buildArtistCard(BuildContext context, ArtistModel artist) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: ThemeColors.primaryColor.withOpacity(0.1),
          backgroundImage:
              artist.avatarUrl != null ? NetworkImage(artist.avatarUrl!) : null,
          child: artist.avatarUrl == null
              ? const Icon(Icons.person,
                  size: 30, color: ThemeColors.primaryColor)
              : null,
        ),
        title: Text(
          artist.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              artist.bio ?? "",
              style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? ThemeColors.white70 : ThemeColors.grey600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
          ),
          onSelected: (value) {
            switch (value) {
              case 'edit':
                _navigateToEditArtist(artist);
                break;
              case 'delete':
                _showDeleteConfirmation(
                    context, artist, context.read<CmsArtistBloc>());
                break;
            }
          },
          itemBuilder: (context) => [
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
          // Navigate to artist details
        },
      ),
    );
  }

  void _navigateToEditArtist(ArtistModel artist) {
    context.push(AppRoutes.editArtist, extra: artist);
  }

  void _showDeleteConfirmation(
      BuildContext context, ArtistModel artist, CmsArtistBloc cmsArtistBloc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Artist'),
        content: Text('Are you sure you want to delete "${artist.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              cmsArtistBloc.add(DeleteArtist(artist.id));
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
