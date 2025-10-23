import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/in_app_screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToAuthLayout();
  }

  Future<void> _navigateToAuthLayout() async {
    await Future.delayed(const Duration(seconds: 2));

    // Check if widget is still mounted before using context
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedSize(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutBack,
          child: Image.asset(
            'assets/splash.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
