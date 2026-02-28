import 'dart:math';

import 'package:flutter/material.dart';

const _dimension = 30.0;

class AppCircularLoader extends StatefulWidget {
  const AppCircularLoader({super.key});

  @override
  State<AppCircularLoader> createState() => _AppCircularLoaderState();
}

class _AppCircularLoaderState extends State<AppCircularLoader>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 12),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) => Transform.rotate(
        angle: _controller.value * 2 * pi,
        child: SizedBox.square(
          dimension: _dimension,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentGeometry.center,
            children: [
              // Sun circle
              _Circle(),

              // 12 rays
              ...List.generate(
                12,
                (index) {
                  final radian = 2 * pi * ((index / 12));

                  return Transform.translate(
                    offset: Offset.fromDirection(
                      radian,
                      _dimension / 2,
                    ),
                    child: Transform.rotate(
                      angle: radian,
                      child: _Ray(
                        direction: radian,
                        initialDelay: Duration(seconds: index),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Circle
class _Circle extends StatefulWidget {
  @override
  State<_Circle> createState() => _CircleState();
}

class _CircleState extends State<_Circle> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
    reverseDuration: Duration(seconds: 1),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) => Transform.scale(
        scale: 1 + (_controller.value - 0.5) * 0.15,
        child: AnimatedContainer(
          width: _dimension / 2,
          duration: Duration(seconds: 1),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1.5,
              color: Color.alphaBlend(
                Colors.green.withAlpha(
                  255 * _controller.value ~/ 1,
                ),
                Colors.white.withAlpha(200),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Ray
class _Ray extends StatefulWidget {
  final double direction;
  final Duration initialDelay;

  const _Ray({
    required this.direction,
    required this.initialDelay,
  });

  @override
  State<_Ray> createState() => __RayState();
}

class __RayState extends State<_Ray> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
    reverseDuration: Duration(seconds: 1),
  );

  @override
  void initState() {
    super.initState();

    Future.delayed(
      widget.initialDelay,
      () {
        if (mounted) {
          _controller.repeat(
            reverse: true,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) => Transform.translate(
        offset: Offset.fromDirection(
          widget.direction,
          _controller.value * 2,
        ),
        child: AnimatedContainer(
          height: 1.5,
          width: _dimension / 6,
          duration: Duration(seconds: 1),
          color: Color.alphaBlend(
            Colors.green.withAlpha(
              255 * _controller.value ~/ 1,
            ),
            Colors.white.withAlpha(200),
          ),
        ),
      ),
    );
  }
}
