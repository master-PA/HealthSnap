import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthsnap_app/models/user_profile_model.dart';
import 'package:healthsnap_app/screens/Health_assesment_screens/screen2.dart';
import 'package:healthsnap_app/screens/in_app_screens/about_screen.dart';
import 'package:healthsnap_app/screens/main_screens/profile.dart';
import 'package:healthsnap_app/screens/main_screens/reminder.dart';
import 'package:healthsnap_app/screens/main_screens/trend.dart';
import 'package:healthsnap_app/services/database_services/user_profile_Service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;

  final List<Widget> _screens = [
    const SurveyScreenSecond(),
    const HealthTrendScreen(),
    const HomeMainView(),
    const ReminderScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 2) {
      setState(() {
        _selectedIndex = 2;
      });
      return false;
    }

    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you really want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (shouldExit == true) {
      exit(0);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(index: _selectedIndex, children: _screens),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF041E7D),
            unselectedItemColor: Colors.grey[600],
            selectedFontSize: 12,
            unselectedFontSize: 12,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.track_changes),
                label: 'Tracking',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.trending_up),
                label: 'Trends',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time),
                label: 'Reminders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_pin),
                label: 'You',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeMainView extends StatefulWidget {
  const HomeMainView({super.key});

  @override
  State<HomeMainView> createState() => _HomeMainViewState();
}

class _HomeMainViewState extends State<HomeMainView> {
  final List<String> _healthTips = [
    'Stay hydrated! Aim for 8 glasses of water today.',
    'Get at least 30 minutes of physical activity daily.',
    'Aim for 7-9 hours of quality sleep each night.',
    'Include fruits and vegetables in every meal.',
    'Take short breaks from sitting every hour.',
    'Practice deep breathing to reduce stress.',
    'Limit processed foods and sugary drinks.',
    'Wash your hands regularly to prevent infections.',
    'Get some sunlight for vitamin D synthesis.',
    'Practice good posture while working.',
    'Schedule regular health check-ups.',
    'Limit screen time before bed for better sleep.',
    'Include protein in your breakfast for sustained energy.',
    'Stretch regularly to maintain flexibility.',
    'Practice mindfulness or meditation daily.',
  ];

  String _currentTip = '';
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _loadRandomTip();
  }

  void _loadRandomTip() {
    setState(() {
      _currentTip = _healthTips[_random.nextInt(_healthTips.length)];
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _loadRandomTip();
  }

  @override
  Widget build(BuildContext context) {
    final userService = UserProfileService();

    return ValueListenableBuilder<UserProfile>(
      valueListenable: userService.userProfileNotifier,
      builder: (context, profile, _) {
        final String userName = profile.name.isNotEmpty ? profile.name : 'User';

        return Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB3E5FC), Color(0xFF4FC3F7)],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    Image.asset('assets/logo.png', height: 40),
                    const Spacer(),
                    PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 28,
                      ),
                      onSelected: (value) {
                        if (value == 'about') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AboutScreen(),
                            ),
                          );
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'about',
                          child: Text('About Us'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                color: const Color(0xFF4FC3F7),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text('👋', style: TextStyle(fontSize: 28)),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome, $userName',
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Ready for a healthy day?',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F4FD),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFB3E5FC)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.lightbulb_outline,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Daily Health Tip',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: _loadRandomTip,
                                  child: const Icon(
                                    Icons.refresh,
                                    color: Color(0xFF4FC3F7),
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _currentTip,
                              style: const TextStyle(
                                color: Color(0xFF041E7D),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Pull down to refresh for more tips',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildFlashCard(
                        icon: Icons.assignment_outlined,
                        title: "Log New Data",
                        subtitle: "Record symptoms, activities, mood",
                        buttonText: "Start Tracking →",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SurveyScreenSecond(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildFlashCard(
                        icon: Icons.notifications_outlined,
                        title: "Set a reminder",
                        subtitle: "Schedule meds, appointments ...",
                        buttonText: "New Reminder →",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReminderScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildFlashCard(
                        icon: Icons.insights_outlined,
                        title: "Check My Trends",
                        subtitle: "Hidden patterns, recommendations",
                        buttonText: "View Insights →",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HealthTrendScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFlashCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF4FC3F7), size: 28),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4FC3F7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: const Color(0xFF4FC3F7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    buttonText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
