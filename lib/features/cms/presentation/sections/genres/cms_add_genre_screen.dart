import '../../../cms_index.dart';

class CMSAddGenreScreen extends StatefulWidget {
  const CMSAddGenreScreen({super.key});

  @override
  State<CMSAddGenreScreen> createState() => _CMSAddGenreScreenState();
}

class _CMSAddGenreScreenState extends State<CMSAddGenreScreen> {
  final _formKey = GlobalKey<FormState>();
  final _genreNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedColor = '#FF6B6B';
  IconData _selectedIcon = Icons.music_note;
  bool _isSaving = false;

  final List<Map<String, dynamic>> _colorOptions = [
    {'name': 'Red', 'value': '#FF6B6B'},
    {'name': 'Blue', 'value': '#4ECDC4'},
    {'name': 'Green', 'value': '#45B7D1'},
    {'name': 'Purple', 'value': '#96CEB4'},
    {'name': 'Orange', 'value': '#FFEAA7'},
    {'name': 'Pink', 'value': '#DDA0DD'},
    {'name': 'Teal', 'value': '#20B2AA'},
    {'name': 'Indigo', 'value': '#6A5ACD'},
  ];

  final List<Map<String, dynamic>> _iconOptions = [
    {'name': 'Music Note', 'icon': Icons.music_note},
    {'name': 'Headphones', 'icon': Icons.headphones},
    {'name': 'Mic', 'icon': Icons.mic},
    {'name': 'Piano', 'icon': Icons.piano},
    {'name': 'Guitar', 'icon': Icons.music_note},
    {'name': 'Drum', 'icon': Icons.music_note},
    {'name': 'Radio', 'icon': Icons.radio},
    {'name': 'Equalizer', 'icon': Icons.equalizer},
  ];

  @override
  void dispose() {
    _genreNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Genre'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _saveGenre,
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
              // Genre Information Card
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

                      // Genre Name
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

                      // Description
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter genre description',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.description),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Color Selection Card
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
                        'Genre Color',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: _colorOptions.map((color) {
                          final isSelected = _selectedColor == color['value'];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColor = color['value'];
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(int.parse(
                                        color['value'].substring(1),
                                        radix: 16) +
                                    0xFF000000),
                                shape: BoxShape.circle,
                                border: isSelected
                                    ? Border.all(
                                        color: ThemeColors.primaryColor,
                                        width: 3)
                                    : null,
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      color: ThemeColors.white,
                                      size: 24,
                                    )
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Icon Selection Card
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
                        'Genre Icon',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: _iconOptions.length,
                        itemBuilder: (context, index) {
                          final iconData = _iconOptions[index]['icon'];
                          final isSelected = _selectedIcon == iconData;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIcon = iconData;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ThemeColors.primaryColor.withOpacity(0.1)
                                    : ThemeColors.grey200,
                                borderRadius: BorderRadius.circular(8),
                                border: isSelected
                                    ? Border.all(
                                        color: ThemeColors.primaryColor,
                                        width: 2)
                                    : null,
                              ),
                              child: Icon(
                                iconData,
                                color: isSelected
                                    ? ThemeColors.primaryColor
                                    : ThemeColors.grey600,
                                size: 32,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Preview Card
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
                        'Preview',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(int.parse(_selectedColor.substring(1),
                                  radix: 16) +
                              0xFF000000),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _selectedIcon,
                              color: ThemeColors.white,
                              size: 32,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _genreNameController.text.isEmpty
                                        ? 'Genre Name'
                                        : _genreNameController.text,
                                    style: const TextStyle(
                                      color: ThemeColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (_descriptionController.text.isNotEmpty)
                                    Text(
                                      _descriptionController.text,
                                      style: const TextStyle(
                                        color: ThemeColors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                ],
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
                  onPressed: _isSaving ? null : _saveGenre,
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
                          'Create Genre',
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

  void _saveGenre() {
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
            content: Text('${_genreNameController.text} created successfully!'),
            backgroundColor: ThemeColors.clrGreen,
          ),
        );

        Navigator.pop(context);
      });
    }
  }
}
