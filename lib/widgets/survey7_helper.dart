import 'package:flutter/material.dart';

class SurveyTextField extends StatelessWidget {
  const SurveyTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.hinttext,
    required this.validator,
    this.keyboardtype = TextInputType.number,
  });

  final String title;
  final TextEditingController controller;
  final String hinttext;
  final TextInputType keyboardtype;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.black, fontSize: 16)),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: keyboardtype,
          controller: controller,
          decoration: InputDecoration(
            hintText: hinttext,
            border: OutlineInputBorder(),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
