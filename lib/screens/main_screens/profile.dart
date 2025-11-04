import 'package:flutter/material.dart';
import 'package:healthsnap_app/models/user_profile_model.dart';
import 'package:healthsnap_app/screens/authentication_screens/login_screen.dart';
import 'package:healthsnap_app/screens/in_app_screens/about_screen.dart';
import 'package:healthsnap_app/services/authentication_services/auth_services.dart';
import 'package:healthsnap_app/services/database_services/user_profile_Service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = UserProfileService();
    final AuthService authService = AuthService();

    return ValueListenableBuilder<UserProfile>(
      valueListenable: userService.userProfileNotifier,
      builder: (context, profile, _) {
        final String username = profile.name.isNotEmpty ? profile.name : 'User';

        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFB3E5FC), Color(0xFF4FC3F7)],
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Profile and Settings",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),

                      ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.person_pin),
                          backgroundColor: Colors.blueGrey,
                          radius: 40,
                        ),
                        title: Text(
                          username,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: const Text(
                          "Email hidden for privacy",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      ListTile(
                        leading: const Icon(
                          Icons.delete_forever,
                          color: Colors.black,
                        ),
                        title: const Text(
                          "Delete Account",
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () => _confirmDelete(context, authService),
                      ),

                      const SizedBox(height: 16),

                      const ListTile(
                        leading: Icon(Icons.edit_square),
                        title: const Text("Edit info"),
                      ),

                      const SizedBox(height: 16),

                      ElevatedButton(
                        onPressed: () => _logout(context, authService),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: Colors.lightBlueAccent,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout, color: Colors.red),
                            SizedBox(width: 8),
                            const Text(
                              "Log Out",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _logout(BuildContext context, AuthService authService) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await authService.logout();

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    }
  }

  void _confirmDelete(BuildContext context, AuthService authService) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This will permanently delete your account and all data. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final result = await authService.deleteAccount();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            backgroundColor: result['success']
                ? Colors.green
                : Colors.redAccent,
          ),
        );

        if (result['success']) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        }
      }
    }
  }
}
