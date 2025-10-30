// Dart imports:
import 'dart:math' as math;
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:groovix/core/core_index.dart';
import 'package:groovix/features/cms/cms_index.dart';
import 'package:groovix/features/cms/songs/domain/models/cms_song_update_model.dart';
import 'package:groovix/features/cms/songs/presentation/bloc/cms_song_bloc.dart';
import 'package:groovix/features/cms/songs/presentation/bloc/cms_song_event.dart';
import 'package:groovix/features/cms/songs/presentation/bloc/cms_song_state.dart';
import 'package:groovix/injection_container/injection_initializer.dart' as di;
import 'package:groovix/routes/routes_index.dart';

class EditSongScreen extends StatefulWidget {
  final SongModel song;

  const EditSongScreen({super.key, required this.song});

  @override
  State<EditSongScreen> createState() => _EditSongScreenState();
}

class _EditSongScreenState extends State<EditSongScreen>
    with TickerProviderStateMixin {
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _songNameController = TextEditingController();

  Color _selectedColor = const Color(0xFF4DA6FF);
  int _selectedPaletteColor = 0;

  late AnimationController _loadingController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initializeFields();
    _setupAnimations();
  }

  void _initializeFields() {
    _artistController.text = widget.song.artistName;
    _songNameController.text = widget.song.songName;

    // Parse hexcode to color
    try {
      _selectedColor = Color(int.parse('FF${widget.song.hexcode}', radix: 16));
    } catch (e) {
      _selectedColor = const Color(0xFF4DA6FF);
    }
  }

  void _setupAnimations() {
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
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CmsSongBloc>(
      create: (context) => di.getIt<CmsSongBloc>(),
      child: BlocListener<CmsSongBloc, CmsSongState>(
        listener: (context, state) {
          if (state is UpdateSongFieldsSuccess) {
            _loadingController.stop();
            context.go(AppRoutes.editSuccess, extra: {
              'type': 'song',
              'title': 'Song Updated Successfully',
              'message':
                  'Your song "${state.song.songName}" has been updated successfully.',
              'song': state.song,
            });
          } else if (state is UpdateSongFieldsFailure) {
            _loadingController.stop();
            showToast(title: 'Update failed: ${state.error}');
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
                  if (state is UpdateSongFieldsLoading)
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
            _buildSongPreview(context),
            const SizedBox(height: 24),
            _buildInputGroup(textColor),
            const SizedBox(height: 24),
            _buildColorSection(textColor),
            const SizedBox(height: 24),
            _buildUpdateButton(textColor),
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
                  // Animated edit icon
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
                              Icons.edit,
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
                    'Updating Your Song',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontFamily: 'Lexend',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Please wait while we update your song...',
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
        Text('Edit Song',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: textColor,
                fontFamily: 'Lexend')),
        BlocBuilder<CmsSongBloc, CmsSongState>(
          builder: (context, state) {
            return IconButton(
              onPressed: state is UpdateSongFieldsLoading
                  ? null
                  : () {
                      _updateSong(context);
                    },
              icon: Icon(Icons.save_rounded,
                  color: state is UpdateSongFieldsLoading
                      ? textColor.withOpacity(0.5)
                      : textColor,
                  size: 30),
              tooltip: 'Save Changes',
            );
          },
        ),
      ],
    );
  }

  Widget _buildSongPreview(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
              backgroundImage: widget.song.thumbnailUrl.isNotEmpty
                  ? NetworkImage(widget.song.thumbnailUrl)
                  : null,
              child: widget.song.thumbnailUrl.isEmpty
                  ? Icon(
                      Icons.music_note,
                      color: Theme.of(context).colorScheme.primary,
                      size: 32,
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.song.songName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontFamily: 'Lexend',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.song.artistName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontFamily: 'Lexend',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _selectedColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Current Color',
                      style: TextStyle(
                        fontSize: 12,
                        color: _getContrastColor(_selectedColor),
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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

  Widget _buildUpdateButton(Color textColor) {
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
            onPressed: state is UpdateSongFieldsLoading
                ? null
                : () {
                    _updateSong(context);
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
                  Icons.save_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Update Song',
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

  void _updateSong(BuildContext context) {
    if (_artistController.text.isNotEmpty &&
        _songNameController.text.isNotEmpty) {
      _loadingController.repeat();

      final updateModel = CmsSongUpdateModel(
        songName: _songNameController.text,
        artist: _artistController.text,
        hexcode:
            _selectedColor.value.toRadixString(16).substring(2).toUpperCase(),
      );

      context
          .read<CmsSongBloc>()
          .add(UpdateSongFields(widget.song.id, updateModel));
    } else {
      showToast(title: 'Please fill all the fields');
    }
  }
}
