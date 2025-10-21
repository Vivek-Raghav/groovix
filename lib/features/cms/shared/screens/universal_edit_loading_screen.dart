import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:groovix/core/core_index.dart';

class UniversalEditLoadingScreen extends StatefulWidget {
  final String type;
  final String title;
  final String message;

  const UniversalEditLoadingScreen({
    super.key,
    required this.type,
    required this.title,
    required this.message,
  });

  @override
  State<UniversalEditLoadingScreen> createState() =>
      _UniversalEditLoadingScreenState();
}

class _UniversalEditLoadingScreenState extends State<UniversalEditLoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _loadingController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
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

  void _startAnimations() {
    _loadingController.repeat();
  }

  @override
  void dispose() {
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? ThemeColors.darkAppColor : ThemeColors.white,
      body: Container(
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
                  color: isDark ? ThemeColors.darkAppColor : ThemeColors.white,
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
                    // Animated icon
                    AnimatedBuilder(
                      animation: Listenable.merge(
                          [_rotationAnimation, _pulseAnimation]),
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
                                    _getTypeColor(),
                                    _getTypeColor().withOpacity(0.7),
                                  ],
                                ),
                              ),
                              child: Icon(
                                _getTypeIcon(),
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: isDark ? ThemeColors.white : ThemeColors.black,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Message
                    Text(
                      widget.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            isDark ? ThemeColors.white70 : ThemeColors.grey600,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Progress indicator
                    SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        backgroundColor: isDark
                            ? ThemeColors.white.withOpacity(0.2)
                            : ThemeColors.clrGrey.withOpacity(0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getTypeColor(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getTypeIcon() {
    switch (widget.type.toLowerCase()) {
      case 'song':
        return Icons.music_note;
      case 'artist':
        return Icons.person;
      case 'playlist':
        return Icons.playlist_play;
      case 'genre':
        return Icons.category;
      default:
        return Icons.edit;
    }
  }

  Color _getTypeColor() {
    switch (widget.type.toLowerCase()) {
      case 'song':
        return ThemeColors.primaryColor;
      case 'artist':
        return Colors.purple;
      case 'playlist':
        return Colors.orange;
      case 'genre':
        return Colors.teal;
      default:
        return ThemeColors.primaryColor;
    }
  }
}
