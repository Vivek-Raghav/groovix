import '../../../cms_index.dart';

class CMSAddSongScreen extends StatefulWidget {
  const CMSAddSongScreen({super.key});

  @override
  State<CMSAddSongScreen> createState() => _CMSAddSongScreenState();
}

class _CMSAddSongScreenState extends State<CMSAddSongScreen> {
  final _formKey = GlobalKey<FormState>();
  final _songNameController = TextEditingController();
  final _artistController = TextEditingController();
  final _albumController = TextEditingController();
  final _durationController = TextEditingController();

  String? _selectedGenre;
  List<String> _selectedCategories = [];
  bool _isUploading = false;

  final List<String> _genres = [
    'Pop',
    'Rock',
    'Hip Hop',
    'Electronic',
    'Jazz',
    'Classical',
    'Country',
    'R&B'
  ];

  final List<String> _categories = [
    'Featured',
    'New Release',
    'Trending',
    'Popular',
    'Exclusive'
  ];

  @override
  void dispose() {
    _songNameController.dispose();
    _artistController.dispose();
    _albumController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Song'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _isUploading ? null : _saveSong,
            child: Text(
              'Save',
              style: TextStyle(
                color: _isUploading ? ThemeColors.white70 : ThemeColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
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
              // Song Information Card
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
                        'Song Information',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 16),

                      // Song Name
                      TextFormField(
                        controller: _songNameController,
                        decoration: const InputDecoration(
                          labelText: 'Song Name *',
                          hintText: 'Enter song name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.music_note),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter song name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Artist
                      TextFormField(
                        controller: _artistController,
                        decoration: const InputDecoration(
                          labelText: 'Artist *',
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

                      // Album
                      TextFormField(
                        controller: _albumController,
                        decoration: const InputDecoration(
                          labelText: 'Album',
                          hintText: 'Enter album name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.album),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Duration
                      TextFormField(
                        controller: _durationController,
                        decoration: const InputDecoration(
                          labelText: 'Duration',
                          hintText: 'e.g., 3:45',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.timer),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Genre and Categories Card
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
                        'Classification',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 16),

                      // Genre Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedGenre,
                        decoration: const InputDecoration(
                          labelText: 'Genre *',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.category),
                        ),
                        items: _genres.map((genre) {
                          return DropdownMenuItem(
                            value: genre,
                            child: Text(genre),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedGenre = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a genre';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Categories Multi-select
                      Text(
                        'Categories',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _categories.map((category) {
                          final isSelected =
                              _selectedCategories.contains(category);
                          return FilterChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedCategories.add(category);
                                } else {
                                  _selectedCategories.remove(category);
                                }
                              });
                            },
                            selectedColor:
                                ThemeColors.primaryColor.withOpacity(0.2),
                            checkmarkColor: ThemeColors.primaryColor,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // File Upload Card
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
                        'File Upload',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 16),

                      // Audio File Upload
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ThemeColors.grey200,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload_file,
                              size: 48,
                              color: ThemeColors.grey,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Upload Audio File',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: ThemeColors.grey600,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'MP3, WAV, FLAC supported',
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
                      const SizedBox(height: 16),

                      // Thumbnail Upload
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ThemeColors.grey200,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              size: 48,
                              color: ThemeColors.grey,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Upload Thumbnail',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: ThemeColors.grey600,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'JPG, PNG supported',
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
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isUploading ? null : _saveSong,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.primaryColor,
                    foregroundColor: ThemeColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isUploading
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
                          'Save Song',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _saveSong() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isUploading = true;
      });

      // Create SongModel with form data
      final song = SongModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        songName: _songNameController.text.trim(),
        artist: _artistController.text.trim(),
        songUrl:
            'https://example.com/audio/${DateTime.now().millisecondsSinceEpoch}.mp3', // Placeholder URL
        thumbnailUrl:
            'https://example.com/thumb/${DateTime.now().millisecondsSinceEpoch}.jpg', // Placeholder URL
        hexcode: '#FF6B6B', // Default color
      );

      // Add song using BLoC
      context.read<CmsSongBloc>().add(CreateSong(song));

      // Simulate upload process
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isUploading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${_songNameController.text} uploaded successfully!'),
            backgroundColor: ThemeColors.clrGreen,
          ),
        );

        Navigator.pop(context);
      });
    }
  }
}
