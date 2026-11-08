import 'dart:math' as math;

import 'package:flutter/material.dart';

class HintShake extends StatefulWidget {
  const HintShake({
    required this.hinted,
    required this.child,
    super.key,
  });

  final bool hinted;
  final Widget child;

  @override
  State<HintShake> createState() => _HintShakeState();
}

class _HintShakeState extends State<HintShake>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );

    if (widget.hinted) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant HintShake oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hinted && !oldWidget.hinted) {
      _controller.forward(from: 0);
    }
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
      child: widget.child,
      builder: (context, child) {
        final progress = _controller.value;
        final offset = math.sin(progress * math.pi * 8) * (1 - progress) * 9;
        return Transform.translate(
          offset: Offset(offset, 0),
          child: child,
        );
      },
    );
  }
}
