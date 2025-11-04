import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/in_app_screens/about_screen.dart';
import 'package:healthsnap_app/services/authentication_services/auth_services.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController _tokenController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  Future<void> verifyEmail() async {
    final token = _tokenController.text.trim();
    if (token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your token'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final result = await _authService.verifyEmail(token: token);

    setState(() => _isLoading = false);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result['message']),
        backgroundColor: result['success'] ? Colors.green : Colors.red,
      ),
    );

    if (result['success']) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Gradient Header
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB3E5FC), Color(0xFF4FC3F7)],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/logo.png', height: 60),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.menu, color: Colors.white, size: 28),
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

          // Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Image.asset('assets/logo.png', height: 150),
                  const SizedBox(height: 24),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    shadowColor: Colors.black26,
                    color: const Color(0xFFF7F8F9),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Verify Email",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Enter the verification token sent to your email.",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),

                          TextField(
                            controller: _tokenController,
                            decoration: const InputDecoration(
                              labelText: "Verification Token",
                              prefixIcon: Icon(Icons.verified_rounded),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : verifyEmail,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4285F4),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      "Verify Email",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Color(0xFFEBA386),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
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
