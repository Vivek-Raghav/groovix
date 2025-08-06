// Flutter imports:
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:groovix/core/theme/app_theme.dart';
import 'package:groovix/features/auth/auth_index.dart';
import 'package:groovix/gen/assets.gen.dart';
import 'package:groovix/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  final _localCache = getIt<LocalCache>();

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startSplashSequence();
  }

  void _initializeAnimations() {
    // Fade animation for smooth appearance
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Scale animation for icon bounce effect
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));
  }

  void _startSplashSequence() async {
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _scaleController.forward();
    await Future.delayed(const Duration(milliseconds: 2500));
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && _localCache.getBool(PrefKeys.isLoggedIn) == true) {
      context.go(AppRoutes.bottomNav);
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.primaryColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: ThemeColors.deepPurple,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Icon with scale animation
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: ThemeColors.white.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Assets.icons.appIcon.image(
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // App Name with gradient text
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        ThemeColors.white,
                        ThemeColors.cyanAccent,
                      ],
                    ).createShader(bounds),
                    child: const Text(
                      'Groovix',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tagline
                  const Text(
                    'Your Music, Your Groove',
                    style: TextStyle(
                      fontSize: 18,
                      color: ThemeColors.white70,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.0,
                    ),
                  ),

                  const SizedBox(height: 80),

                  // Loading indicator
                  const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ThemeColors.white,
                      ),
                      strokeWidth: 3,
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
}

class NavigationHelper {
  /// Navigate to login screen
  static void navigateToLogin(BuildContext context) {
    context.go(AppRoutes.login);
  }

  /// Navigate to signup screen
  static void navigateToSignup(BuildContext context) {
    context.go(AppRoutes.signup);
  }

  /// Navigate to onboarding screen
  static void navigateToOnboarding(BuildContext context) {
    context.go(AppRoutes.initial);
  }

  /// Navigate to main navigation
  static void navigateToMain(BuildContext context) {
    context.go(AppRoutes.initial);
  }

  /// Navigate to settings
  static void navigateToSettings(BuildContext context) {
    context.go(AppRoutes.settings);
  }
}
