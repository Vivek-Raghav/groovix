// Flutter imports:
import "package:flutter/material.dart";

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:groovix/routes/app_routes.dart';

class NavigationHelper {
  // GoRouter Navigation Methods
  static void goTo(BuildContext context, String route) {
    context.go(route);
  }

  static void pushTo(BuildContext context, String route) {
    context.push(route);
  }

  static void replaceTo(BuildContext context, String route) {
    context.replace(route);
  }

  static void pop(BuildContext context) {
    context.pop();
  }

  // Specific Navigation Methods
  static void navigateToSplash(BuildContext context) {
    context.go(AppRoutes.splash);
  }

  static void navigateToHome(BuildContext context) {
    context.go(AppRoutes.initial);
  }

  static void navigateToBottomNav(BuildContext context) {
    context.go(AppRoutes.bottomNav);
  }

  static void navigateToExplore(BuildContext context) {
    context.go(AppRoutes.explore);
  }

  static void navigateToLibrary(BuildContext context) {
    context.go(AppRoutes.library);
  }

  static void navigateToPlaylist(BuildContext context) {
    context.go(AppRoutes.playlist);
  }

  static void navigateToSettings(BuildContext context) {
    context.go(AppRoutes.settings);
  }

  static void navigateToLogin(BuildContext context) {
    context.go(AppRoutes.login);
  }

  static void navigateToSignup(BuildContext context) {
    context.go(AppRoutes.signup);
  }

  static void navigateToOnboarding(BuildContext context) {
    context.go(AppRoutes.onboarding);
  }

  // Legacy Navigator Methods (for backward compatibility)
  static Future<T?> pushPage<T>(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static Future<T?> pushReplacementPage<T>(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static Future<T?> pushAndRemoveUntilPage<T>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }
}
