// Dart imports:
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';

// Project imports:
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

  Color _selectedColor = const Color(0xFFFF4500);
  int _selectedColorTab = 2;
  int _selectedPaletteColor = 1;
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
          if (state is SongSuccess) {
            _loadingController.stop();
            context.go(AppRoutes.uploadSuccess,
                extra: state.uploadSongResponse);
          } else if (state is SongFailure) {
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
                  if (state is SongLoading) _buildLoadingOverlay(context),
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
        padding: const EdgeInsets.all(16.0),
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
            if (_selectedAudioFile != null) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedAudioFile = null;
                        _fileController.clear();
                      });
                    },
                    icon: Icon(Icons.delete,
                        color: theme.colorScheme.error, size: 16),
                    label: Text(
                      'Remove Audio',
                      style: TextStyle(
                          color: theme.colorScheme.error, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            _buildTextField('Artist', 'Artist', _artistController, textColor),
            const SizedBox(height: 16),
            _buildTextField(
                'Song Name', 'Song Name', _songNameController, textColor),
            const SizedBox(height: 24),
            _buildColorSection(textColor),
            const SizedBox(height: 16),
            _buildColorWheel(textColor),
            const SizedBox(height: 16),
            _buildColorPalette(textColor),
            const SizedBox(height: 24),
            _buildSelectedColorIndicator(textColor),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: textColor,
            size: 20,
          ),
        ),
        Text(
          'Upload Song',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: textColor,
            fontFamily: 'Lexend',
          ),
        ),
        const SizedBox(width: 20),
        BlocBuilder<SongCubit, SongState>(
          builder: (context, state) {
            return IconButton(
              onPressed: state is SongLoading
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
              icon: Icon(Icons.upload,
                  color: state is SongLoading
                      ? textColor.withOpacity(0.5)
                      : textColor,
                  size: 20),
              tooltip: 'Upload Song',
            );
          },
        ),
      ],
    );
  }

  Widget _buildThumbnailPicker(Color textColor) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: textColor,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: _pickImageFromStorage,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: textColor.withOpacity(0.3),
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
                    Icon(
                      Icons.folder_outlined,
                      color: textColor,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select the thumbnail for your song',
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor.withOpacity(0.7),
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
    return _selectedAudioFile != null
        ? AudioWave(path: _selectedAudioFile!.path)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pick Song',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _fileController,
                readOnly: true,
                onTap: _pickAudioFromStorage,
                style: TextStyle(
                  color: textColor,
                  fontFamily: 'Lexend',
                ),
                decoration: InputDecoration(
                  hintText: 'Pick Song',
                  hintStyle: TextStyle(
                    color: textColor.withOpacity(0.4),
                    fontFamily: 'Lexend',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: textColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: textColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: textColor),
                  ),
                  suffixIcon: Icon(
                    Icons.attach_file,
                    color: textColor,
                  ),
                ),
              ),
            ],
          );
  }

  Widget _buildTextField(String label, String hint,
      TextEditingController controller, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
            fontFamily: 'Lexend',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: TextStyle(
            color: textColor,
            fontFamily: 'Lexend',
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: textColor.withOpacity(0.4),
              fontFamily: 'Lexend',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: textColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: textColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: textColor),
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
          'Select color',
          style: TextStyle(
            fontSize: 14,
            color: textColor,
            fontFamily: 'Lexend',
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildColorTab('Primary', 0, textColor),
            const SizedBox(width: 16),
            _buildColorTab('Accent', 1, textColor),
            const SizedBox(width: 16),
            _buildColorTab('Wheel', 2, textColor),
          ],
        ),
      ],
    );
  }

  Widget _buildColorTab(String label, int index, Color textColor) {
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
          color: isSelected ? textColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: textColor,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).scaffoldBackgroundColor
                : textColor,
            fontSize: 14,
            fontFamily: 'Lexend',
          ),
        ),
      ),
    );
  }

  Widget _buildColorWheel(Color textColor) {
    if (_selectedColorTab != 2) return const SizedBox.shrink();

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: textColor.withOpacity(0.3)),
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
                    color: isSelected
                        ? textColor
                        : const Color.fromARGB(255, 208, 198, 198),
                    width: 0.5,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: textColor,
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

  Widget _buildSelectedColorIndicator(Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: textColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: textColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _selectedColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: textColor, width: 2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Color',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Lexend',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '#${_selectedColor.value.toRadixString(16).substring(2).toUpperCase()}',
                  style: TextStyle(
                    color: textColor.withOpacity(0.7),
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
