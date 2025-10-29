import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/authentication_screens/create_account.dart';
import 'package:healthsnap_app/screens/main_screens/home.dart';
import 'package:healthsnap_app/services/authentication_services/auth_services.dart';
import 'package:healthsnap_app/widgets/loading_widget.dart';

class AuthLayout extends StatefulWidget {
  const AuthLayout({super.key, this.pageIfNotConnected});
  final Widget? pageIfNotConnected;

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  final _authService = AuthService();
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final loggedIn = await _authService.isLoggedIn();
    if (mounted) {
      setState(() {
        _isLoggedIn = loggedIn;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingWidget();
    }

    return _isLoggedIn
        ? const HomeScreen()
        : widget.pageIfNotConnected ?? const RegisterScreen();
  }
}
