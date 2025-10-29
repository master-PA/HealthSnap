import 'package:flutter/material.dart';
import 'package:healthsnap_app/widgets/home_flashcard.dart';
import 'package:healthsnap_app/widgets/tip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[100]!, Colors.orange],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/logo.png', height: 80),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          const Text(
            "👏 Welcome , Health Enthusiast! ",
            style: TextStyle(color: Color(0xFF041E7D), fontSize: 30),
          ),
          const SizedBox(height: 30),
          const Tip(),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeFlashcard(
                icon: Icons.receipt_long_rounded,
                title: "Log New Data",
                subtitle: "Record symptoms,activities,mood",
                buttontext: "Start Tracking",
              ),
              HomeFlashcard(
                icon: Icons.notifications_none_sharp,
                title: "Set a Reminder",
                subtitle: "Schedule meds,appointments",
                buttontext: "New Reminder",
              ),
              HomeFlashcard(
                icon: Icons.trending_up,
                title: "Check my Trends",
                subtitle: "Hidden Patterns,recommendations",
                buttontext: "View Insights",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
