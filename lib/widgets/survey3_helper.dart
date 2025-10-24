import 'package:flutter/material.dart';

class SurveySingleOption extends StatelessWidget {
  const SurveySingleOption({
    super.key,
    required this.title,
    required this.first,
    required this.second,
    this.third = '',
    required this.noOfOptions,
    required this.selectedValue,
    required this.onChanged,
  });

  final String title;
  final String first;
  final String second;
  final String third;
  final int noOfOptions;
  final String? selectedValue;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: Text(first),
                value: first,
                activeColor: Colors.blue,
                groupValue: selectedValue,
                onChanged: onChanged,
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text(second),
                value: second,
                activeColor: Colors.blue,
                groupValue: selectedValue,
                onChanged: onChanged,
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
            if (noOfOptions == 3)
              Expanded(
                child: RadioListTile<String>(
                  title: Text(third),
                  value: third,
                  activeColor: Colors.blue,
                  groupValue: selectedValue,
                  onChanged: onChanged,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
