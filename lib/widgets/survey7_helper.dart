import 'package:flutter/material.dart';

class SurveyTextField extends StatelessWidget {
  const SurveyTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.hinttext,
    this.keyboardtype = TextInputType.number,
  });

  final String title;
  final TextEditingController controller;
  final String hinttext;
  final TextInputType keyboardtype;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(color: Colors.black, fontSize: 16)),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: keyboardtype,
          controller: controller,
          decoration: InputDecoration(
            focusColor: Colors.blue,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            hintText: hinttext,
            hintStyle: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }
}
