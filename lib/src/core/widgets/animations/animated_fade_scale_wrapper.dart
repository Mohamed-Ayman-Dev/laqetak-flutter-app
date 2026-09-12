import 'package:flutter/material.dart';

class AnimatedFadeScaleWrapper extends StatefulWidget {
  const AnimatedFadeScaleWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.delay = Duration.zero,
    this.beginScale = 0.9,
    this.curve = Curves.easeOutCubic,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final double beginScale;
  final Curve curve;

  @override
  State<AnimatedFadeScaleWrapper> createState() =>
      _AnimatedFadeScaleWrapperState();
}

class _AnimatedFadeScaleWrapperState extends State<AnimatedFadeScaleWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _scale = Tween<double>(
      begin: widget.beginScale,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.8, curve: Curves.easeOut),
      ),
    );

    // استنى أول frame يترسم قبل ما تبدأ الحركة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (widget.delay == Duration.zero) {
        _controller.forward();
      } else {
        Future.delayed(widget.delay, () {
          if (mounted) _controller.forward();
        });
      }
    });
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
        return Opacity(
          opacity: _opacity.value,
          child: Transform.scale(scale: _scale.value, child: child),
        );
      },
    );
  }
}
