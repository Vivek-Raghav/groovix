import '../../../cms_index.dart';

class CMSAddArtistScreen extends StatefulWidget {
  const CMSAddArtistScreen({super.key});

  @override
  State<CMSAddArtistScreen> createState() => _CMSAddArtistScreenState();
}

class _CMSAddArtistScreenState extends State<CMSAddArtistScreen> {
  final _formKey = GlobalKey<FormState>();
  final _artistNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _websiteController = TextEditingController();

  List<String> _selectedGenres = [];
  bool _isVerified = false;
  bool _isSaving = false;

  final List<String> _availableGenres = [
    'Pop',
    'Rock',
    'Hip Hop',
    'Electronic',
    'Jazz',
    'Classical',
    'Country',
    'R&B',
    'Alternative',
    'Folk'
  ];

  @override
  void dispose() {
    _artistNameController.dispose();
    _bioController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Artist'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _saveArtist,
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

                      // Website
                      TextFormField(
                        controller: _websiteController,
                        decoration: const InputDecoration(
                          labelText: 'Website',
                          hintText: 'Enter artist website URL',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.web),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Verified Status
                      SwitchListTile(
                        title: const Text('Verified Artist'),
                        subtitle: const Text('Mark this artist as verified'),
                        value: _isVerified,
                        onChanged: (value) {
                          setState(() {
                            _isVerified = value;
                          });
                        },
                        activeColor: ThemeColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Profile Image Upload Card
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
                        'Profile Image',
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
                              Icons.person_add,
                              size: 64,
                              color: ThemeColors.grey,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Upload Profile Image',
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

              // Genres Selection Card
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
                        'Artist Genres',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _availableGenres.map((genre) {
                          final isSelected = _selectedGenres.contains(genre);
                          return FilterChip(
                            label: Text(genre),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedGenres.add(genre);
                                } else {
                                  _selectedGenres.remove(genre);
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

              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveArtist,
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
                          'Create Artist',
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

  void _saveArtist() {
    if (_formKey.currentState!.validate()) {
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
                Text('${_artistNameController.text} created successfully!'),
            backgroundColor: ThemeColors.clrGreen,
          ),
        );

        Navigator.pop(context);
      });
    }
  }
}
