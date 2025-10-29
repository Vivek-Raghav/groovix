import 'package:groovix/core/shared/widgets/common_back_button.dart';
import 'package:groovix/features/cms/genres/domain/models/genre_update.dart';
import 'package:groovix/features/cms/genres/domain/models/update_genre_params.dart';
import 'package:groovix/features/cms/genres/presentation/bloc/cms_genre_bloc.dart';
import 'package:groovix/features/cms/genres/presentation/bloc/cms_genre_event.dart';
import 'package:groovix/features/cms/genres/presentation/bloc/cms_genre_state.dart';
import 'package:groovix/features/cms/shared/widgets/loading_overlay.dart';
import 'package:groovix/routes/routes_index.dart';

class CMSEditGenreScreen extends StatefulWidget {
  final GenreModel genre;

  const CMSEditGenreScreen({super.key, required this.genre});

  @override
  State<CMSEditGenreScreen> createState() => _CMSEditGenreScreenState();
}

class _CMSEditGenreScreenState extends State<CMSEditGenreScreen> {
  final _formKey = GlobalKey<FormState>();
  final _genreNameController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _genreNameController.text = widget.genre.name;
    _bioController.text = widget.genre.bio;
  }

  @override
  void dispose() {
    _genreNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CmsGenreBloc, CmsGenreState>(
      listener: (context, state) {
        if (state is UpdateGenreLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Genre updated successfully!'),
              backgroundColor: ThemeColors.clrGreen,
            ),
          );
          context.pop(context);
        } else if (state is UpdateGenreError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: ThemeColors.red,
            ),
          );
        }
      },
      child: BlocBuilder<CmsGenreBloc, CmsGenreState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? ThemeColors.darkAppColor
                : ThemeColors.white,
            appBar: AppBar(
              title: const Text('Edit Genre'),
              backgroundColor: ThemeColors.primaryColor,
              foregroundColor: ThemeColors.white,
              elevation: 0,
              centerTitle: true,
              leading: const CommonBackButton()),
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGenreInfoCard(),
                        const SizedBox(height: 16),
                        _buildCoverImageDisplay(),
                        const SizedBox(height: 32),
                        _buildUpdateButton(state),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                if (state is UpdateGenreLoading)
                  const LoadingOverlay(
                    title: 'Updating Genre',
                    message: 'Please wait while we update your genre...',
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGenreInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Genre Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _genreNameController,
              decoration: const InputDecoration(
                labelText: 'Genre Name *',
                hintText: 'Enter genre name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter genre name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _bioController,
              decoration: const InputDecoration(
                labelText: 'Bio *',
                hintText: 'Enter genre bio',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter genre bio';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImageDisplay() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cover Image',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            if (widget.genre.coverUrl.isNotEmpty)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(widget.genre.coverUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: ThemeColors.grey200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.image, size: 64, color: ThemeColors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateButton(CmsGenreState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state is UpdateGenreLoading ? null : _updateGenre,
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColors.primaryColor,
          foregroundColor: ThemeColors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: state is UpdateGenreLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(ThemeColors.white),
                ),
              )
            : const Text(
                'Update Genre',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  void _updateGenre() {
    if (_formKey.currentState!.validate()) {
      final genreUpdate = GenreUpdate(
        name: _genreNameController.text.trim(),
        bio: _bioController.text.trim(),
      );

      final params = UpdateGenreParams(
        genreId: widget.genre.id,
        update: genreUpdate,
      );

      getIt<CmsGenreBloc>().add(UpdateGenre(widget.genre.id, params));
    }
  }
}
