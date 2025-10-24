import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/in_app_screens/health_assesment_screen.dart';
import 'package:healthsnap_app/widgets/bulletin.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final List<String> _words = ['patterns', 'needs', 'signals'];

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _words.length;
        });
        _startAnimation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/logo.png', height: 80),

                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.menu, color: Colors.white54),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              const Text(
                "Stop guessing,\nstart understanding\nyour body's",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.3),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  _words[_currentIndex],
                  key: ValueKey<String>(_words[_currentIndex]),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bullet(text: "Log your Data, Effortlessly"),
                  Bullet(text: "Uncover Hidden trends with AI"),
                  Bullet(text: "Stay on Track with Smart Reminders"),
                  Bullet(text: "Receive Personalized Wellness Tips"),
                ],
              ),

              const SizedBox(height: 36),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HealthAssesmentScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Start Tracking →",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              Center(
                child: Image.asset(
                  'assets/doctors.png',
                  width: size.width * 0.8,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
