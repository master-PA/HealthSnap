import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color = Colors.white, this.size = 200});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: LoadingAnimationWidget.progressiveDots(
          color: Colors.white,
          size: 200,
        ),
      ),
    );
  }
}
