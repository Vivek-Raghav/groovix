import "../../../../theme/app_theme.dart";
import "../bloc/connectivity_bloc.dart";
import "../bloc/events_states.dart";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AppOfflineScreen extends StatelessWidget {
  const AppOfflineScreen({
    super.key,
    this.imageSizeMultiplier = 0.5,
    this.showFullScreen = true,
  });

  final double imageSizeMultiplier;
  final bool showFullScreen;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        return showFullScreen
            ? Scaffold(body: _buildContent(context, isSmallScreen))
            : _buildContent(context, isSmallScreen);
      },
    );
  }

  Widget _buildContent(BuildContext context, bool isSmallScreen) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: showFullScreen ? 24.0 : 16.0,
          vertical: showFullScreen ? 32.0 : 16.0,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: showFullScreen ? 600 : 400,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                size: (isSmallScreen ? 200 : 250) * imageSizeMultiplier,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: showFullScreen ? 24 : 16),
              Text(
                "Content is not available",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                      // fontSize: isSmallScreen ? 20 : 24,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: showFullScreen ? 8 : 4),
              Text(
                "Looks like you're offline. Check your connection and try again",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).hintColor,
                      // fontSize: isSmallScreen ? 14 : 16,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: showFullScreen ? 8 : 4),
              Text(
                "(Turn on Internet connection and see the magic)",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).hintColor,
                      //     fontSize: isSmallScreen ? 12 : 14,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppOfflineBanner extends StatelessWidget {
  const AppOfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 40,
        color: ThemeColors.primaryColor.withOpacity(0.6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              "No Internet Connection",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
