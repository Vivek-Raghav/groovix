// Dart imports:
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';

// Project imports:
import 'package:groovix/core/core_index.dart';
import 'package:groovix/features/cms/cms_index.dart';

class UploadSongScreen extends StatefulWidget {
  const UploadSongScreen({super.key});

  @override
  State<UploadSongScreen> createState() => _UploadSongScreenState();
}

class _UploadSongScreenState extends State<UploadSongScreen>
    with TickerProviderStateMixin {
  final TextEditingController _songNameController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();

  Color _selectedColor = const Color(0xFF4DA6FF);
  int _selectedPaletteColor = 0;
  File? _selectedAudioFile;
  File? _selectedThumbnail;
  ArtistModel? _selectedArtist;

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

    // Initialize artists list
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<CmsArtistBloc>()
          .add(FetchArtistsList(ArtistsQueryModel(page: 1, size: 100)));
    });
  }

  @override
  void dispose() {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<CmsSongBloc>.value(value: getIt<CmsSongBloc>()),
        BlocProvider<CmsArtistBloc>.value(value: getIt<CmsArtistBloc>()),
      ],
      child: BlocListener<CmsSongBloc, CmsSongState>(
        listener: (context, state) {
          if (state is UploadSongSuccess) {
            _loadingController.stop();
            context.go(AppRoutes.uploadSuccess,
                extra: state.uploadSongResponse);
            _selectedThumbnail = null;
            _selectedAudioFile = null;
            _selectedArtist = null;
            _songNameController.clear();
            _selectedColor = const Color(0xFF7C3AED);
            _selectedPaletteColor = 0;
          } else if (state is UploadSongFailure) {
            _loadingController.stop();
            showToast(title: 'Upload failed: ${state.error}');
          }
        },
        child: BlocBuilder<CmsSongBloc, CmsSongState>(
          builder: (context, state) {
            return Scaffold(
              body: Stack(
                children: [
                  // Main content
                  _buildMainContent(context),
                  // Loading overlay
                  if (state is UploadCmsSongLoading)
                    _buildLoadingOverlay(context),
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
        padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
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
            const SizedBox(height: 24),
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
        const CommonBackButton(),
        Text('Upload Song',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: textColor,
                fontFamily: 'Lexend')),
        BlocBuilder<CmsSongBloc, CmsSongState>(
          builder: (context, state) {
            return IconButton(
              onPressed: state is UploadCmsSongLoading
                  ? null
                  : () {
                      if (_selectedThumbnail != null &&
                          _selectedAudioFile != null &&
                          _selectedArtist != null &&
                          _songNameController.text.isNotEmpty) {
                        _loadingController.repeat();
                        context
                            .read<CmsSongBloc>()
                            .add(UploadSong(UploadSongModel(
                              thumbnailFile: _selectedThumbnail!,
                              song: _selectedAudioFile!,
                              artistId: _selectedArtist!.id,
                              songName: _songNameController.text,
                              hexcode: _selectedColor.value
                                  .toRadixString(16)
                                  .substring(2)
                                  .toUpperCase(),
                            )));
                      } else {
                        showToast(title: 'Please fill all the fields');
                      }
                    },
              icon: Icon(Icons.cloud_upload_rounded,
                  color: state is UploadCmsSongLoading
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
                      Image.file(_selectedThumbnail!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(8)),
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
              _selectedAudioFile != null
                  ? const SizedBox.shrink()
                  : Icon(
                      Icons.music_note_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
              const SizedBox(width: 16),
              Expanded(
                child: _selectedAudioFile != null
                    ? AudioWave(path: _selectedAudioFile!.path)
                    : Column(
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
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
        _buildArtistSelector(textColor),
        const SizedBox(height: 12),
        _buildInputField(
          label: 'Song Name',
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

  Widget _buildArtistSelector(Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Artist',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
            fontFamily: 'Lexend',
          ),
        ),
        const SizedBox(height: 8),
        BlocBuilder<CmsArtistBloc, CmsArtistState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: Theme.of(context).colorScheme.outline),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ArtistModel>(
                  value: _selectedArtist,
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Choose an artist',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  isExpanded: true,
                  items: state is CmsArtistLoaded
                      ? state.artists.map((ArtistModel artist) {
                          return DropdownMenuItem<ArtistModel>(
                            value: artist,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      artist.name,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontFamily: 'Lexend',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList()
                      : [],
                  onChanged: (ArtistModel? newValue) {
                    setState(() {
                      _selectedArtist = newValue;
                    });
                  },
                ),
              ),
            );
          },
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
        const SizedBox(height: 20),
        _buildColorPalette(textColor),
        const SizedBox(height: 20),
        _buildColorPreview(),
      ],
    );
  }

  Widget _buildColorPalette(Color textColor) {
    final colors = [
      const Color(0xFF4DA6FF), // Sky Blue
      const Color(0xFF8A5BE7), // Royal Purple
      const Color(0xFFFF6B6B), // Coral Red
      const Color(0xFF00BFA6), // Teal Green
      const Color(0xFFFFB84D), // Amber
      const Color(0xFFE056FD), // Violet Pink
      const Color(0xFF6C757D), // Slate Gray
      const Color(0xFF40E0D0), // Soft Cyan
      const Color(0xFF3F51B5), // Indigo Blue
      const Color(0xFFFFD966), // Warm yellow
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
                });
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: colors[index],
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).textTheme.bodyMedium!.color!
                        : ThemeColors.clrTransparent,
                    width: isSelected ? 2 : 1,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
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
    return BlocBuilder<CmsSongBloc, CmsSongState>(
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
            onPressed: state is UploadCmsSongLoading
                ? null
                : () {
                    if (_selectedThumbnail != null &&
                        _selectedAudioFile != null &&
                        _selectedArtist != null &&
                        _songNameController.text.isNotEmpty) {
                      _loadingController.repeat();
                      context
                          .read<CmsSongBloc>()
                          .add(UploadSong(UploadSongModel(
                            thumbnailFile: _selectedThumbnail!,
                            song: _selectedAudioFile!,
                            artistId: _selectedArtist!.id,
                            songName: _songNameController.text,
                            hexcode: _selectedColor.value
                                .toRadixString(16)
                                .substring(2)
                                .toUpperCase(),
                          )));
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
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
