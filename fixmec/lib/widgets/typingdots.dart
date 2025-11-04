import 'package:flutter/material.dart';

class Typingdots extends StatefulWidget {
  const Typingdots({super.key});

  @override
  State<Typingdots> createState() => _TypingdotsState();
}

class _TypingdotsState extends State<Typingdots>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return Opacity(
              opacity: (_animation.value * 3 - index).clamp(0.0, 1.0),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: CircleAvatar(radius: 6, backgroundColor: Colors.grey),
              ),
            );
          }),
        );
      },
    );
  }
}
