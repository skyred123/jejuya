import 'package:flutter/material.dart';

/// The widget is a custom button that can be used in the app.
class BouncesAnimatedButton extends StatefulWidget {
  /// Constructor for the BouncesAnimatedButton widget.
  const BouncesAnimatedButton({
    required this.leading,
    this.width = double.infinity,
    this.height = 48,
    super.key,
    this.beginScale = 1.0,
    this.endScale = 0.95,
    this.onPressed,
    this.padding,
    this.alignment = Alignment.center,
    this.decoration,
    this.disabled = false,
    this.shouldOpacityOnDisabled = true,
  });

  /// The [leading] widget.
  final Widget leading;

  /// The [beginScale] widget.
  final double beginScale;

  /// The [endScale] widget.
  final double endScale;

  /// The [width] widget.
  final double? width;

  /// The [height] widget.
  final double? height;

  /// The [disabled] widget.
  final bool disabled;

  /// Indicate if the button should be opacity when disabled.
  final bool shouldOpacityOnDisabled;

  /// The [onPressed] widget.
  final VoidCallback? onPressed;

  /// The [padding] widget.
  final EdgeInsetsGeometry? padding;

  /// The [alignment] widget.
  final AlignmentGeometry alignment;

  /// The [decoration] widget.
  final Decoration? decoration;

  @override
  State<BouncesAnimatedButton> createState() => _BouncesAnimatedButtonState();
}

class _BouncesAnimatedButtonState extends State<BouncesAnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _scaleAnimation;
  bool _isTapUp = false;
  final Duration _duration = const Duration(milliseconds: 50);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );

    _scaleAnimation = Tween<double>(
      begin: widget.beginScale,
      end: widget.endScale,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation?.value,
          child: GestureDetector(
            onTapDown: !widget.disabled ? _onTapDown : null,
            onTapUp: !widget.disabled ? _onTapUp : null,
            onTapCancel: !widget.disabled ? _onTapCancel : null,
            onTap: () {
              if (widget.disabled) return;
              // CustomHapticFeedback().lightImpact();
              if (_isTapUp) {
                /// Skip this check for now b/c on browsers, the tapUp
                /// event sometimes doesn't fire
              }
              widget.onPressed?.call();
            },
            child: Opacity(
              opacity:
                  widget.disabled && widget.shouldOpacityOnDisabled ? 0.3 : 1.0,
              child: ColoredBox(
                // Workaround to expand button hit target
                color: Colors.white.withValues(alpha: 0.0001),
                child: Container(
                  alignment: widget.alignment,
                  width: widget.width,
                  height: widget.height,
                  padding: widget.padding,
                  decoration: widget.decoration,
                  child: widget.leading,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTapDown(TapDownDetails details) {
    _isTapUp = false;
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _isTapUp = true;
  }

  void _onTapCancel() {
    _isTapUp = false;
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
