import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'Snowflake.dart';

class SnowfallAnimation extends StatefulWidget {
  @override
  _SnowfallAnimationState createState() => _SnowfallAnimationState();
}

class _SnowfallAnimationState extends State<SnowfallAnimation>
    with SingleTickerProviderStateMixin {
  final List<Snowflake> snowflakes = [];
  final Random random = Random();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(minutes: 1),
      vsync: this,
    )..repeat();
    for (int i = 0; i < 100; i++) {
      snowflakes.add(Snowflake(
        random.nextDouble(),
        random.nextDouble(),
        random.nextDouble() * 5 + 2,
        random.nextDouble() * 1 + 1,
      ));
    }
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        for (final snowflake in snowflakes) {
          snowflake.y += snowflake.speed;
          if (snowflake.y > 1) {
            snowflake.y = 0;
            snowflake.x = random.nextDouble();
          }
        }
        return Stack(
          children: [
            for (final snowflake in snowflakes)
              Positioned(
                left: snowflake.x * MediaQuery.of(context).size.width,
                top: snowflake.y * MediaQuery.of(context).size.height,
                child: Container(
                  width: snowflake.size,
                  height: snowflake.size,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
