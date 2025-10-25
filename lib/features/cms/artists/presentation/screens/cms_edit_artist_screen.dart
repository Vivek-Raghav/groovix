// Project imports:
import '../../../cms_index.dart';

class CMSEditArtistScreen extends StatefulWidget {
  final ArtistModel artist;

  const CMSEditArtistScreen({
    super.key,
    required this.artist,
  });

  @override
  State<CMSEditArtistScreen> createState() => _CMSEditArtistScreenState();
}

class _CMSEditArtistScreenState extends State<CMSEditArtistScreen> {
  final _formKey = GlobalKey<FormState>();
  final _artistNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _avatarUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _artistNameController.text = widget.artist.name;
    _bioController.text = widget.artist.bio ?? '';
    _avatarUrlController.text = widget.artist.avatarUrl ?? '';
  }

  @override
  void dispose() {
    _artistNameController.dispose();
    _bioController.dispose();
    _avatarUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? ThemeColors.darkAppColor
          : ThemeColors.white,
      appBar: AppBar(
        title: const Text('Edit Artist'),
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
          if (state is UpdateArtistSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.artist.name} updated successfully!'),
                backgroundColor: ThemeColors.clrGreen,
              ),
            );
            Navigator.pop(context);
          } else if (state is UpdateArtistFailure) {
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

                        // Avatar URL
                        TextFormField(
                          controller: _avatarUrlController,
                          decoration: const InputDecoration(
                            labelText: 'Avatar URL',
                            hintText: 'Enter avatar image URL',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.image),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Update Button
                BlocBuilder<CmsArtistBloc, CmsArtistState>(
                  builder: (context, state) {
                    final isLoading = state is UpdateArtistLoading;

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _updateArtist,
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
                                'Update Artist',
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

  void _updateArtist() {
    if (_formKey.currentState!.validate()) {
      final artistUpdate = ArtistUpdate(
        name: _artistNameController.text.trim(),
        avatarUrl: _avatarUrlController.text.trim(),
        bio: _bioController.text.trim(),
      );

      context
          .read<CmsArtistBloc>()
          .add(UpdateArtist(widget.artist.id, artistUpdate));
    }
  }
}
