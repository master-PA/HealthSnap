import 'package:flutter/material.dart';

class SurveyProgressIndicator extends StatelessWidget {
  final int currentStep;

  const SurveyProgressIndicator({super.key, required this.currentStep});

  Color _circleColor(int step) {
    return step <= currentStep ? Colors.blue : Colors.grey;
  }

  Color _lineColor(int linePosition) {
    return linePosition < currentStep ? Colors.blue : Colors.grey;
  }

  Widget _circle(int step) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _circleColor(step),
      ),
    );
  }

  Widget _line(int position) {
    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        height: 4,
        color: _lineColor(position),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [_circle(1), _line(1), _circle(2), _line(2), _circle(3)]),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Introduction'), Text('Tracking'), Text('Result')],
        ),
      ],
    );
  }
}
