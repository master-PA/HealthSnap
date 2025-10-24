import 'package:flutter/material.dart';
import 'package:healthsnap_app/screens/authentication_screens/create_account.dart';
import 'package:healthsnap_app/screens/authentication_screens/forgot_password.dart';
import 'package:healthsnap_app/services/authentication_services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailc = TextEditingController();
  final TextEditingController _passwordc = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isVisible = ValueNotifier(false);

  @override
  void dispose() {
    _emailc.dispose();
    _passwordc.dispose();
    isVisible.dispose();
    super.dispose();
  }

  void logIn() {
    if (_formKey.currentState!.validate()) {
      authService.value.signIn(email: _emailc.text, password: _passwordc.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/logo.png', height: 80),

                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1644E8),
                            shape: const StadiumBorder(),
                          ),
                          child: const Text(
                            'Create ⟶',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.menu, color: Colors.white54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              Image.asset('assets/logo.png', height: 150),

              const SizedBox(height: 30),

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
                    vertical: 30,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontSize: 60,
                        ),
                      ),

                      const SizedBox(height: 25),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailc,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: "Email Address",
                                prefixIcon: Icon(Icons.email_rounded),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter an Email address";
                                }
                                if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                ).hasMatch(value)) {
                                  return "Enter a valid Email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            ValueListenableBuilder(
                              valueListenable: isVisible,
                              builder: (context, visible, _) {
                                return TextFormField(
                                  controller: _passwordc,
                                  obscureText: !visible,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    prefixIcon: const Icon(Icons.lock_rounded),
                                    border: const OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      onPressed: () =>
                                          isVisible.value = !isVisible.value,
                                      icon: Icon(
                                        visible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter a Password";
                                    }

                                    return null;
                                  },
                                );
                              },
                            ),

                            const SizedBox(height: 24),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: logIn,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFEBA386),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  "Sign in",
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPassword(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Forgot your password?',
                                style: TextStyle(
                                  color: Color(0xFFEBA386),
                                  fontSize: 12,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),
                            Row(
                              children: const [
                                Expanded(child: Divider(thickness: 1)),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text("OR"),
                                ),
                                Expanded(child: Divider(thickness: 1)),
                              ],
                            ),
                            const SizedBox(height: 16),

                            OutlinedButton.icon(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              icon: Image.asset(
                                'assets/google.png',
                                height: 20,
                              ),
                              label: const Text(
                                "Continue with Google",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
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
        ),
      ),
    );
  }
}
