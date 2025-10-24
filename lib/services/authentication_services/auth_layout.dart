import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/authentication_screens/create_account.dart';
import 'package:healthsnap_app/screens/main_screens/dashboard.dart';
import 'package:healthsnap_app/services/authentication_services/auth_services.dart';
import 'package:healthsnap_app/widgets/loading_widget.dart';

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
              return widget = LoadingWidget();
            } else if (snapshot.hasData) {
              widget = DashboardScreen();
            } else {
              widget = pageIfNotConnected ?? RegisterScreen();
            }
            return widget;
          },
        );
      },
    );
  }
}
