import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scrollbar(
        trackVisibility: true,
        interactive: true,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB3E5FC), Color(0xFF4FC3F7)],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SafeArea(
                bottom: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About healthSnap: Your Smart Health Companion',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Empowering you to take proactive control of your well-being',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'In todays fast-paced world, over-looking minor health signals or missing medication is common . HealthSnap is here to change that.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Image.asset(
                        'assets/about1.png',
                        height: 150,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.purple.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.health_and_safety,
                              size: 80,
                              color: Colors.purple.shade300,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Center(
                      child: Text(
                        'The HealthSnap Difference',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildFeatureCard(
                      'Simple Tracking',
                      'Log symptoms, activities and medication with unparalleled ease.',
                      Icons.edit_calendar,
                      Colors.orange.shade50,
                      Colors.orange,
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureCard(
                      'Intelligent Analysis',
                      'Uncover hidden trends and receive personalized wellness tips powered by advanced AI.',
                      Icons.psychology,
                      Colors.blue.shade50,
                      Colors.blue,
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureCard(
                      'Reliable Reminders',
                      '" Never miss a dose or an important activity with timely, cross platform notification "',
                      Icons.notifications_active,
                      Colors.purple.shade50,
                      Colors.purple,
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'HealthSnap is built on a robust and modern technology stack ...',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Center(
                    // child: Image.asset(
                    //   'assets/tech_illustration.png',
                    //   height: 150,
                    //   errorBuilder: (context, error, stackTrace) {
                    //     return Container(
                    //       height: 150,
                    //       width: 150,
                    //       decoration: BoxDecoration(
                    //         color: Colors.blue.shade50,
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       child: Icon(
                    //         Icons.phone_android,
                    //         size: 80,
                    //         color: Colors.blue.shade300,
                    //       ),
                    //     );
                    //   },
                    // ),
                    // ),
                    // const SizedBox(height: 40),
                    // const Center(
                    //   child: Text(
                    //     'Ready to take control of your health ?',
                    //     style: TextStyle(fontSize: 16, color: Colors.black87),
                    //   ),
                    // ),
                    // const SizedBox(height: 16),
                    // Center(
                    //   child: ElevatedButton(
                    //     onPressed: () {},
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.blue,
                    //       foregroundColor: Colors.white,
                    //       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(8),
                    //       ),
                    //     ),
                    //     child: const Row(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         Text(
                    //           'Start',
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         ),
                    //         SizedBox(width: 8),
                    //         Icon(Icons.arrow_forward, size: 18),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    String title,
    String description,
    IconData icon,
    Color bgColor,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 60, color: iconColor),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
