// Dart imports:
import 'dart:io';

// Project imports:
import '../../../cms_index.dart';
import '../../../../cms/songs/presentation/widgets/file_picker.dart';

class CMSAddArtistScreen extends StatefulWidget {
  const CMSAddArtistScreen({super.key});

  @override
  State<CMSAddArtistScreen> createState() => _CMSAddArtistScreenState();
}

class _CMSAddArtistScreenState extends State<CMSAddArtistScreen> {
  final _formKey = GlobalKey<FormState>();
  final _artistNameController = TextEditingController();
  final _bioController = TextEditingController();

  File? _selectedAvatarFile;

  @override
  void dispose() {
    _artistNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _pickAvatarFromStorage() async {
    final image = await pickImageFromStorage();
    if (image != null) {
      setState(() {
        _selectedAvatarFile = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? ThemeColors.darkAppColor
          : ThemeColors.white,
      appBar: AppBar(
        title: const Text('Add New Artist'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<CmsArtistBloc, CmsArtistState>(
        listener: (context, state) {
          if (state is CreateArtistSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.artist.name} created successfully!'),
                backgroundColor: ThemeColors.clrGreen,
              ),
            );
            Navigator.pop(context);
          } else if (state is CreateArtistFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.error}'),
                backgroundColor: ThemeColors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Artist Information Card
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
                          'Artist Information',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 16),

                        // Artist Name
                        TextFormField(
                          controller: _artistNameController,
                          decoration: const InputDecoration(
                            labelText: 'Artist Name *',
                            hintText: 'Enter artist name',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter artist name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Bio
                        TextFormField(
                          controller: _bioController,
                          decoration: const InputDecoration(
                            labelText: 'Biography',
                            hintText: 'Enter artist biography',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.description),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),

                        // Avatar Upload Section
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ThemeColors.grey200,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _selectedAvatarFile != null
                              ? Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        _selectedAvatarFile!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedAvatarFile = null;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : GestureDetector(
                                  onTap: _pickAvatarFromStorage,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person_add,
                                        size: 64,
                                        color: ThemeColors.grey,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Upload Avatar Image',
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
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Save Button
                BlocBuilder<CmsArtistBloc, CmsArtistState>(
                  builder: (context, state) {
                    final isLoading = state is CreateArtistLoading;

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _saveArtist,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColors.primaryColor,
                          foregroundColor: ThemeColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
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
                                'Create Artist',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveArtist() {
    if (_formKey.currentState!.validate()) {
      if (_selectedAvatarFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an avatar image'),
            backgroundColor: ThemeColors.red,
          ),
        );
        return;
      }

      final artistParams = ArtistParams(
        name: _artistNameController.text.trim(),
        avatarFile: _selectedAvatarFile!,
        bio: _bioController.text.trim(),
      );

      getIt<CmsArtistBloc>().add(CreateArtist(artistParams));
    }
  }
}
