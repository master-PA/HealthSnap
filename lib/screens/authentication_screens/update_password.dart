import 'package:flutter/material.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final TextEditingController _emailc = TextEditingController();
  final TextEditingController _oldpasswordc = TextEditingController();
  final TextEditingController _newpasswordc = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailc.dispose();
    _oldpasswordc.dispose();
    _newpasswordc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Password"), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailc,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.email_rounded),
                labelText: "Email Address",
                hintText: "xyz123@gmail.com",
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
            SizedBox(height: 20),

            TextFormField(
              controller: _oldpasswordc,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                icon: Icon(Icons.password_rounded),
                labelText: "Old Password",
                hintText: "******",
                border: OutlineInputBorder(),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter a Password";
                }
                if (value.length < 6) {
                  return "Password must be of atleast 6 digits";
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            TextFormField(
              controller: _newpasswordc,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                icon: Icon(Icons.password_rounded),
                labelText: "New Password",
                hintText: "******",
                border: OutlineInputBorder(),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Create a Password";
                }
                if (value.length < 6) {
                  return "Password must be of atleast 6 digits";
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 60,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: BoxBorder.all(width: 12),
                    color: Colors.blue,
                  ),
                  child: Text("Confirm"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
