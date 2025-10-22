// Dart imports:
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:groovix/core/core_index.dart';
import 'package:groovix/routes/routes_index.dart';

class UniversalEditSuccessScreen extends StatefulWidget {
  final String type;
  final String title;
  final String message;
  final Map<String, dynamic> data;

  const UniversalEditSuccessScreen({
    super.key,
    required this.type,
    required this.title,
    required this.message,
    required this.data,
  });

  @override
  State<UniversalEditSuccessScreen> createState() =>
      _UniversalEditSuccessScreenState();
}

class _UniversalEditSuccessScreenState extends State<UniversalEditSuccessScreen>
    with TickerProviderStateMixin {
  late AnimationController _successController;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _successController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _successController,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _successController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimations() {
    _successController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _successController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? ThemeColors.darkAppColor : ThemeColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Animation
              _buildSuccessAnimation(),
              const SizedBox(height: 40),

              // Title
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? ThemeColors.white : ThemeColors.black,
                  fontFamily: 'Lexend',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Message
              Text(
                widget.message,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
                  fontFamily: 'Lexend',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Action Buttons
              _buildActionButtons(context, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessAnimation() {
    return AnimatedBuilder(
      animation: Listenable.merge(
          [_scaleAnimation, _rotationAnimation, _pulseAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value * _pulseAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value * 2 * math.pi,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    ThemeColors.clrGreen,
                    ThemeColors.clrGreen.withOpacity(0.7),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.clrGreen.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                _getSuccessIcon(),
                color: Colors.white,
                size: 60,
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getSuccessIcon() {
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
        return Icons.check_circle;
    }
  }

  Widget _buildActionButtons(BuildContext context, bool isDark) {
    return Column(
      children: [
        // Primary Action Button
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                ThemeColors.primaryColor,
                ThemeColors.primaryColor.withOpacity(0.8),
              ],
            ),
          ),
          child: ElevatedButton(
            onPressed: () {
              _handlePrimaryAction(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getPrimaryActionIcon(),
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  _getPrimaryActionText(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Lexend',
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Secondary Action Button
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isDark ? ThemeColors.white70 : Colors.grey.shade400,
              width: 1,
            ),
          ),
          child: ElevatedButton(
            onPressed: () {
              _handleSecondaryAction(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home,
                  color: isDark ? ThemeColors.white70 : Colors.grey.shade600,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Back to Dashboard',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? ThemeColors.white70 : Colors.grey.shade600,
                    fontFamily: 'Lexend',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  IconData _getPrimaryActionIcon() {
    switch (widget.type.toLowerCase()) {
      case 'song':
        return Icons.music_note;
      case 'artist':
        return Icons.person_add;
      case 'playlist':
        return Icons.playlist_add;
      case 'genre':
        return Icons.category;
      default:
        return Icons.add;
    }
  }

  String _getPrimaryActionText() {
    switch (widget.type.toLowerCase()) {
      case 'song':
        return 'Add Another Song';
      case 'artist':
        return 'Add Another Artist';
      case 'playlist':
        return 'Create Another Playlist';
      case 'genre':
        return 'Add Another Genre';
      default:
        return 'Add Another';
    }
  }

  void _handlePrimaryAction(BuildContext context) {
    switch (widget.type.toLowerCase()) {
      case 'song':
        context.go(AppRoutes.uploadSong);
        break;
      case 'artist':
        // Navigate to add artist screen
        context.go(AppRoutes.cmsDashboard);
        break;
      case 'playlist':
        // Navigate to add playlist screen
        context.go(AppRoutes.cmsDashboard);
        break;
      case 'genre':
        // Navigate to add genre screen
        context.go(AppRoutes.cmsDashboard);
        break;
      default:
        context.go(AppRoutes.cmsDashboard);
    }
  }

  void _handleSecondaryAction(BuildContext context) {
    context.go(AppRoutes.cmsDashboard);
  }
}
