// Dart imports:
import 'dart:io';

// Project imports:
import 'package:groovix/features/cms/cms_index.dart';

class CMSAddGenreScreen extends StatefulWidget {
  const CMSAddGenreScreen({super.key});

  @override
  State<CMSAddGenreScreen> createState() => _CMSAddGenreScreenState();
}

class _CMSAddGenreScreenState extends State<CMSAddGenreScreen> {
  final _formKey = GlobalKey<FormState>();
  final _genreNameController = TextEditingController();
  final _bioController = TextEditingController();

  File? _selectedCoverFile;

  @override
  void dispose() {
    _genreNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _pickCoverFromStorage() async {
    final image = await pickImageFromStorage();
    if (image != null) {
      setState(() {
        _selectedCoverFile = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CmsGenreBloc, CmsGenreState>(
      listener: (context, state) {
        if (state is CreateGenreLoaded) {
          context.pop(context);
        } else if (state is CreateGenreError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: ThemeColors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add New Genre'),
          backgroundColor: ThemeColors.primaryColor,
          foregroundColor: ThemeColors.white,
          elevation: 0,
          centerTitle: true,
          actions: [
            BlocBuilder<CmsGenreBloc, CmsGenreState>(
              builder: (context, state) {
                return TextButton(
                  onPressed: state is CreateGenreLoading ? null : _createGenre,
                  child: Text(
                    state is CreateGenreLoading ? 'Creating...' : 'Save',
                    style: TextStyle(
                      color: state is CreateGenreLoading
                          ? ThemeColors.white70
                          : ThemeColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
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
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
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
                ),
                const SizedBox(height: 16),
                Card(
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
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: _pickCoverFromStorage,
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ThemeColors.grey200,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              image: _selectedCoverFile != null
                                  ? DecorationImage(
                                      image: FileImage(_selectedCoverFile!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: _selectedCoverFile == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 64,
                                        color: ThemeColors.grey,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Upload Cover Image',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: ThemeColors.grey600,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'JPG, PNG supported • Recommended: 500x500px',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: ThemeColors.grey,
                                            ),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    children: [
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedCoverFile = null;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                              color: Colors.black54,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.close,
                                                color: Colors.white, size: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<CmsGenreBloc, CmsGenreState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed:
                            state is CreateGenreLoading ? null : _createGenre,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColors.primaryColor,
                          foregroundColor: ThemeColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: state is CreateGenreLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      ThemeColors.white),
                                ),
                              )
                            : const Text(
                                'Create Genre',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createGenre() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCoverFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a cover image'),
            backgroundColor: ThemeColors.red,
          ),
        );
        return;
      }

      final params = GenreParams(
        name: _genreNameController.text.trim(),
        bio: _bioController.text.trim(),
        coverFile: _selectedCoverFile!,
      );

      getIt<CmsGenreBloc>().add(CreateGenre(params));
    }
  }
}
