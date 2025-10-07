// Project imports:
import 'package:groovix/features/onboarding/onboarding_index.dart';

/// OnboardingScreen - Figma-inspired UI only (no logic)
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.deepPurple,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TODO: Replace with Figma illustration asset
              const Icon(Icons.headphones, size: 100, color: ThemeColors.white),
              const SizedBox(height: 32),
              Text(
                'Welcome to Groovix',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: ThemeColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Discover, stream, and enjoy your favorite music with Groovix. Your music journey starts here!',
                style: TextStyle(color: ThemeColors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.white,
                  foregroundColor: ThemeColors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Get Started'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text('Already have an account? Login',
                    style: TextStyle(color: ThemeColors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
