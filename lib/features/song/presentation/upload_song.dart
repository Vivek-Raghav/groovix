import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/file_picker.dart';

class UploadSongScreen extends StatefulWidget {
  const UploadSongScreen({super.key});

  @override
  State<UploadSongScreen> createState() => _UploadSongScreenState();
}

class _UploadSongScreenState extends State<UploadSongScreen> {
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _songNameController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();

  Color _selectedColor = const Color(0xFFFF4500);
  int _selectedColorTab = 2;
  int _selectedPaletteColor = 1;
  Offset _selectedColorPosition = const Offset(100, 100);
  File? _selectedAudioFile;
  File? _selectedThumbnail;

  @override
  void dispose() {
    _artistController.dispose();
    _songNameController.dispose();
    _fileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildThumbnailPicker(),
              if (_selectedThumbnail != null) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _selectedThumbnail = null;
                        });
                      },
                      icon:
                          const Icon(Icons.delete, color: Colors.red, size: 16),
                      label: const Text(
                        'Remove Thumbnail',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              _buildFilePickerField(),
              if (_selectedAudioFile != null) ...[
                const SizedBox(height: 12),
                FileInfoWidget(
                  file: _selectedAudioFile!,
                  onRemove: () {
                    setState(() {
                      _selectedAudioFile = null;
                      _fileController.clear();
                    });
                  },
                ),
              ],
              const SizedBox(height: 16),
              _buildTextField('Artist', 'Artist', _artistController),
              const SizedBox(height: 16),
              _buildTextField('Song Name', 'Song Name', _songNameController),
              const SizedBox(height: 24),
              _buildColorSection(),
              const SizedBox(height: 16),
              _buildColorWheel(),
              const SizedBox(height: 16),
              _buildColorPalette(),
              const SizedBox(height: 24),
              _buildSelectedColorIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
        ),
        const Text(
          'Upload Song',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: 'Lexend',
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildThumbnailPicker() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () async {
          final File? image = await FilePickerWidget.pickImageFromGallery();
          if (image != null) {
            setState(() {
              _selectedThumbnail = image;
            });
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          child: _selectedThumbnail != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _selectedThumbnail!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.folder_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select the thumbnail for your song',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildFilePickerField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pick Song',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: 'Lexend',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _fileController,
          readOnly: true,
          onTap: () async {
            final File? audio = await FilePickerWidget.pickAudioFromStorage();
            if (audio != null) {
              setState(() {
                _selectedAudioFile = audio;
                _fileController.text = FilePickerWidget.getFullFileName(audio);
              });
            }
          },
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Lexend',
          ),
          decoration: InputDecoration(
            hintText: 'Pick Song',
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontFamily: 'Lexend',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white),
            ),
            suffixIcon: const Icon(
              Icons.attach_file,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: 'Lexend',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Lexend',
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontFamily: 'Lexend',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select color',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontFamily: 'Lexend',
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildColorTab('Primary', 0),
            const SizedBox(width: 16),
            _buildColorTab('Accent', 1),
            const SizedBox(width: 16),
            _buildColorTab('Wheel', 2),
          ],
        ),
      ],
    );
  }

  Widget _buildColorTab(String label, int index) {
    final isSelected = _selectedColorTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColorTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontSize: 14,
            fontFamily: 'Lexend',
          ),
        ),
      ),
    );
  }

  Widget _buildColorWheel() {
    if (_selectedColorTab != 2) return const SizedBox.shrink();

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: GestureDetector(
        onTapDown: (details) {
          _handleColorWheelTap(details.localPosition);
        },
        onPanUpdate: (details) {
          _handleColorWheelTap(details.localPosition);
        },
        child: Stack(
          children: [
            // Color wheel background
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const SweepGradient(
                  colors: [
                    Color(0xFFFF0000),
                    Color(0xFFFF7F00),
                    Color(0xFFFFFF00),
                    Color(0xFF00FF00),
                    Color(0xFF0000FF),
                    Color(0xFF4B0082),
                    Color(0xFF8F00FF),
                    Color(0xFFFF0000),
                  ],
                ),
              ),
            ),
            // Brightness control overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),
            // Selection indicator - shows current selected color position
            Positioned(
              left: _selectedColorPosition.dx - 6,
              top: _selectedColorPosition.dy - 6,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPalette() {
    final colors = [
      const Color(0xFFFFFFFF),
      const Color(0xFFFF0000),
      const Color(0xFF00FF00),
      const Color(0xFF0000FF),
      const Color(0xFFFFFF00),
      const Color(0xFFFF00FF),
      const Color(0xFF00FFFF),
      const Color(0xFF808080),
      const Color(0xFF000000),
      const Color(0xFFFFA500),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(colors.length, (index) {
            final isSelected = _selectedPaletteColor == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPaletteColor = index;
                  _selectedColor = colors[index];
                  // Reset wheel position when palette color is selected
                  _selectedColorPosition = const Offset(100, 100);
                });
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colors[index],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      )
                    : null,
              ),
            );
          }),
        ),
      ],
    );
  }

  void _handleColorWheelTap(Offset position) {
    // Add haptic feedback for better user experience
    HapticFeedback.lightImpact();

    setState(() {
      _selectedColorPosition = position;
      _selectedColor = _getColorFromPosition(position);
    });
  }

  Color _getColorFromPosition(Offset position) {
    // Get the container dimensions (assuming 200 height and full width)
    final containerWidth =
        MediaQuery.of(context).size.width - 32; // Account for padding
    final containerHeight = 200.0;

    // Calculate the center of the color wheel
    final centerX = containerWidth / 2;
    final centerY = containerHeight / 2;

    // Calculate distance from center
    final dx = position.dx - centerX;
    final dy = position.dy - centerY;
    final distance = math.sqrt(dx * dx + dy * dy);

    // Calculate angle (0 to 2π)
    double angle = math.atan2(dy, dx);
    if (angle < 0) angle += 2 * math.pi;

    // Calculate brightness based on distance from center (0 to 1)
    final maxDistance = math.min(centerX, centerY);
    final brightness =
        math.max(0.0, math.min(1.0, 1.0 - (distance / maxDistance) * 0.5));

    // Map angle to hue (0 to 360)
    final hue = (angle * 180 / math.pi) % 360;

    // Convert HSV to RGB
    return HSVColor.fromAHSV(1.0, hue, 1.0, brightness).toColor();
  }

  Widget _buildSelectedColorIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _selectedColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selected Color',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Lexend',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '#${_selectedColor.value.toRadixString(16).substring(2).toUpperCase()}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                    fontFamily: 'Lexend',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
