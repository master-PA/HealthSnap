import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/authentication_screens/login_screen.dart';
import 'package:healthsnap_app/screens/main_screens/homescreen.dart';
import 'package:healthsnap_app/services/authentication_services/auth_services.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.pageIfNotConnected});

  final Widget? pageIfNotConnected;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, authService, child) {
        return StreamBuilder(
          stream: authService.authStateChanges,
          builder: (context, snapshot) {
            Widget widget;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return widget = Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              widget = Homescreen();
            } else {
              widget = pageIfNotConnected ?? LoginScreen();
            }
            return widget;
          },
        );
      },
    );
  }
}
