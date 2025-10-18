// Dart imports:
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';
import 'package:groovix/routes/routes_index.dart';

class UploadSongScreen extends StatefulWidget {
  const UploadSongScreen({super.key});

  @override
  State<UploadSongScreen> createState() => _UploadSongScreenState();
}

class _UploadSongScreenState extends State<UploadSongScreen>
    with TickerProviderStateMixin {
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _songNameController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();

  Color _selectedColor =
      const Color(0xFF7C3AED); // Use primary color as default
  int _selectedColorTab = 2;
  int _selectedPaletteColor = 0; // Primary color is now at index 0
  Offset _selectedColorPosition = const Offset(100, 100);
  File? _selectedAudioFile;
  File? _selectedThumbnail;

  late AnimationController _loadingController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _loadingController,
      curve: Curves.linear,
    ));
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _loadingController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _artistController.dispose();
    _songNameController.dispose();
    _fileController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  void _pickImageFromStorage() async {
    final image = await pickImageFromStorage();
    if (image != null) {
      setState(() {
        _selectedThumbnail = image;
      });
    }
  }

  void _pickAudioFromStorage() async {
    final audio = await pickAudioFromStorage();
    if (audio != null) {
      setState(() {
        _selectedAudioFile = audio;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SongCubit>(
      create: (context) => getIt<SongCubit>(),
      child: BlocListener<SongCubit, SongState>(
        listener: (context, state) {
          if (state is UploadSongSuccess) {
            _loadingController.stop();
            context.go(AppRoutes.uploadSuccess,
                extra: state.uploadSongResponse);
            _selectedThumbnail = null;
            _selectedAudioFile = null;
            _artistController.clear();
            _songNameController.clear();
            _selectedColor = const Color(0xFF7C3AED);
            _selectedColorTab = 2;
            _selectedPaletteColor = 0;
            _selectedColorPosition = const Offset(100, 100);
          } else if (state is UploadSongFailure) {
            _loadingController.stop();
            showToast(title: 'Upload failed: ${state.error}');
          }
        },
        child: BlocBuilder<SongCubit, SongState>(
          builder: (context, state) {
            return Scaffold(
              body: Stack(
                children: [
                  // Main content
                  _buildMainContent(context),
                  // Loading overlay
                  if (state is UploadSongLoading) _buildLoadingOverlay(context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium!.color!;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(textColor),
            const SizedBox(height: 24),
            _selectedThumbnail != null
                ? _buildThumbnailPickerWithDelete(textColor)
                : _buildThumbnailPicker(textColor),
            const SizedBox(height: 24),
            _buildAudioPickerField(textColor),
            const SizedBox(height: 16),
            _buildInputGroup(textColor),
            const SizedBox(height: 24),
            _buildColorSection(textColor),
            const SizedBox(height: 24),
            _buildUploadButton(textColor),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingOverlay(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.black.withOpacity(0.1),
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(32),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated upload icon
                  AnimatedBuilder(
                    animation:
                        Listenable.merge([_rotationAnimation, _pulseAnimation]),
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value,
                        child: Transform.rotate(
                          angle: _rotationAnimation.value * 2 * math.pi,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.7),
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.upload,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Uploading Your Song',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontFamily: 'Lexend',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Please wait while we upload your masterpiece...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withOpacity(0.7),
                      fontFamily: 'Lexend',
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color textColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.music_note,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Upload Song',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: textColor,
            fontFamily: 'Lexend',
          ),
        ),
        const Expanded(child: SizedBox()),
        BlocBuilder<SongCubit, SongState>(
          builder: (context, state) {
            return IconButton(
              onPressed: state is UploadSongLoading
                  ? null
                  : () {
                      if (_selectedThumbnail != null &&
                          _selectedAudioFile != null &&
                          _artistController.text.isNotEmpty &&
                          _songNameController.text.isNotEmpty) {
                        _loadingController.repeat();
                        context.read<SongCubit>().uploadSong(UploadSongModel(
                              thumbnailFile: _selectedThumbnail!,
                              song: _selectedAudioFile!,
                              artist: _artistController.text,
                              songName: _songNameController.text,
                              hexcode: _selectedColor.value
                                  .toRadixString(16)
                                  .substring(2)
                                  .toUpperCase(),
                            ));
                      } else {
                        showToast(title: 'Please fill all the fields');
                      }
                    },
              icon: Icon(Icons.cloud_upload_rounded,
                  color: state is UploadSongLoading
                      ? textColor.withOpacity(0.5)
                      : textColor,
                  size: 30),
              tooltip: 'Start Upload',
            );
          },
        ),
      ],
    );
  }

  Widget _buildThumbnailPicker(Color textColor) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: InkWell(
        onTap: _pickImageFromStorage,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          child: _selectedThumbnail != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.file(
                        _selectedThumbnail!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _selectedThumbnail = null;
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 36,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Select or Drop Thumbnail',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildThumbnailPickerWithDelete(Color textColor) {
    return Stack(
      children: [
        Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: textColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(_selectedThumbnail!, fit: BoxFit.cover),
            )),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: () {
              setState(() {
                _selectedThumbnail = null;
              });
            },
            icon: Icon(Icons.delete, color: textColor, size: 20),
          ),
        )
      ],
    );
  }

  Widget _buildAudioPickerField(Color textColor) {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: _pickAudioFromStorage,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.music_note_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pick Audio File',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _selectedAudioFile != null
                          ? _selectedAudioFile!.path.split('/').last
                          : 'Choose .mp3, .wav, or .aac',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ],
                ),
              ),
              if (_selectedAudioFile != null)
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedAudioFile = null;
                    });
                  },
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputGroup(Color textColor) {
    return Column(
      children: [
        _buildInputField(
          label: 'Artist Name',
          placeholder: 'Enter Artist Name',
          controller: _artistController,
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 12),
        _buildInputField(
          label: 'Song Title',
          placeholder: 'Enter Song Name',
          controller: _songNameController,
          icon: Icons.music_note_outlined,
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required String placeholder,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
            fontFamily: 'Lexend',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).colorScheme.outline),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontFamily: 'Lexend',
            ),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontFamily: 'Lexend',
              ),
              prefixIcon: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorSection(Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Color',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
            fontFamily: 'Lexend',
          ),
        ),
        const SizedBox(height: 16),
        _buildTabButtons(),
        const SizedBox(height: 20),
        if (_selectedColorTab == 2) _buildColorWheel(textColor),
        const SizedBox(height: 20),
        _buildColorPalette(textColor),
        const SizedBox(height: 20),
        _buildColorPreview(),
      ],
    );
  }

  Widget _buildTabButtons() {
    final tabs = ['Primary', 'Accent', 'Wheel'];
    return Row(
      children: tabs.asMap().entries.map((entry) {
        final index = entry.key;
        final tab = entry.value;
        final isSelected = _selectedColorTab == index;

        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: index < tabs.length - 1 ? 8 : 0,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColorTab = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Text(
                  tab,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Lexend',
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildColorWheel(Color textColor) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
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
                    Color(0xFFEF4444), // Red
                    Color(0xFFF59E0B), // Orange
                    Color(0xFFEAB308), // Yellow
                    Color(0xFF10B981), // Green
                    Color(0xFF06B6D4), // Cyan
                    Color(0xFF3B82F6), // Blue
                    Color(0xFF8B5CF6), // Purple
                    Color(0xFFEC4899), // Pink
                    Color(0xFFEF4444), // Red (complete circle)
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
                  color: textColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPalette(Color textColor) {
    final colors = [
      const Color(0xFFFFFFFF), // White
      const Color(0xFFFF0000), // Red
      const Color(0xFF00FF00), // Green
      const Color(0xFF0000FF), // Blue
      const Color(0xFFFFFF00), // Yellow
      const Color(0xFFFF00FF), // Magenta
      const Color(0xFF00FFFF), // Cyan
      const Color(0xFF808080), // Gray
      const Color(0xFF000000), // Black
      const Color(0xFFFFA500), // Orange
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
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: colors[index],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                    width: isSelected ? 3 : 1,
                  ),
                ),
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

  Color _getContrastColor(Color color) {
    // Calculate luminance
    final luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  Widget _buildColorPreview() {
    final hexColor =
        _selectedColor.value.toRadixString(16).substring(2).toUpperCase();
    final contrastColor = _getContrastColor(_selectedColor);

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: _selectedColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'HEX: $hexColor',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: contrastColor,
                  fontFamily: 'Lexend',
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: hexColor));
                showToast(title: 'Copied!');
              },
              icon: Icon(
                Icons.content_copy_rounded,
                color: contrastColor,
                size: 20,
              ),
              tooltip: 'Copy Hex',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton(Color textColor) {
    return BlocBuilder<SongCubit, SongState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
          child: ElevatedButton(
            onPressed: state is UploadSongLoading
                ? null
                : () {
                    if (_selectedThumbnail != null &&
                        _selectedAudioFile != null &&
                        _artistController.text.isNotEmpty &&
                        _songNameController.text.isNotEmpty) {
                      _loadingController.repeat();
                      context.read<SongCubit>().uploadSong(UploadSongModel(
                            thumbnailFile: _selectedThumbnail!,
                            song: _selectedAudioFile!,
                            artist: _artistController.text,
                            songName: _songNameController.text,
                            hexcode: _selectedColor.value
                                .toRadixString(16)
                                .substring(2)
                                .toUpperCase(),
                          ));
                    } else {
                      showToast(title: 'Please fill all the fields');
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Upload Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Lexend',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
