import 'package:flutter/material.dart';

class TrafficLightWidget extends StatelessWidget {
  final Color color;
  final bool isActive;

  const TrafficLightWidget({
    super.key,
    required this.color,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: isActive ? 1.0 : 0.3,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black, // กรอบสีดำ
            width: 3, // ความหนาของกรอบ
          ),
        ),
      ),
    );
  }
}
