import '../../cms_index.dart';

class CMSAddPlaylistScreen extends StatefulWidget {
  const CMSAddPlaylistScreen({super.key});

  @override
  State<CMSAddPlaylistScreen> createState() => _CMSAddPlaylistScreenState();
}

class _CMSAddPlaylistScreenState extends State<CMSAddPlaylistScreen> {
  final _formKey = GlobalKey<FormState>();
  final _playlistNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<String> _selectedSongs = [];
  bool _isPublic = true;
  bool _isSaving = false;

  // Mock songs data
  final List<Map<String, dynamic>> _availableSongs = [
    {
      'id': '1',
      'name': 'Summer Vibes',
      'artist': 'Artist One',
      'duration': '3:45'
    },
    {
      'id': '2',
      'name': 'Chill Night',
      'artist': 'Artist Two',
      'duration': '4:12'
    },
    {
      'id': '3',
      'name': 'Dance Floor',
      'artist': 'Artist Three',
      'duration': '3:28'
    },
    {
      'id': '4',
      'name': 'Acoustic Dreams',
      'artist': 'Artist Four',
      'duration': '4:05'
    },
    {
      'id': '5',
      'name': 'Electronic Pulse',
      'artist': 'Artist Five',
      'duration': '3:52'
    },
  ];

  @override
  void dispose() {
    _playlistNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Playlist'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _savePlaylist,
            child: Text(
              'Save',
              style: TextStyle(
                color: _isSaving ? ThemeColors.white70 : ThemeColors.white,
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
              // Playlist Information Card
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
                        'Playlist Information',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 16),

                      // Playlist Name
                      TextFormField(
                        controller: _playlistNameController,
                        decoration: const InputDecoration(
                          labelText: 'Playlist Name *',
                          hintText: 'Enter playlist name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.queue_music),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter playlist name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Description
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter playlist description',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.description),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),

                      // Privacy Setting
                      SwitchListTile(
                        title: const Text('Public Playlist'),
                        subtitle: const Text(
                            'Make this playlist visible to all users'),
                        value: _isPublic,
                        onChanged: (value) {
                          setState(() {
                            _isPublic = value;
                          });
                        },
                        activeColor: ThemeColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Cover Image Upload Card
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
                        child: Column(
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Songs Selection Card
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select Songs',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            '${_selectedSongs.length} selected',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: ThemeColors.primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Songs List
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: ThemeColors.grey200),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          itemCount: _availableSongs.length,
                          itemBuilder: (context, index) {
                            final song = _availableSongs[index];
                            final isSelected =
                                _selectedSongs.contains(song['id']);

                            return CheckboxListTile(
                              title: Text(song['name']),
                              subtitle: Text(
                                  '${song['artist']} • ${song['duration']}'),
                              value: isSelected,
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    _selectedSongs.add(song['id']);
                                  } else {
                                    _selectedSongs.remove(song['id']);
                                  }
                                });
                              },
                              activeColor: ThemeColors.primaryColor,
                            );
                          },
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
                  onPressed: _isSaving ? null : _savePlaylist,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.primaryColor,
                    foregroundColor: ThemeColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSaving
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
                          'Create Playlist',
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

  void _savePlaylist() {
    if (_formKey.currentState!.validate()) {
      if (_selectedSongs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one song'),
            backgroundColor: ThemeColors.red,
          ),
        );
        return;
      }

      setState(() {
        _isSaving = true;
      });

      // Simulate save process
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isSaving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('${_playlistNameController.text} created successfully!'),
            backgroundColor: ThemeColors.clrGreen,
          ),
        );

        Navigator.pop(context);
      });
    }
  }
}
