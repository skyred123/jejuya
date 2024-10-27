import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:glassmorphism/glassmorphism.dart';

/// The [ContainerType] enum defines the types of containers that can be used.
enum ContainerType {
  /// A container with a flat style.
  flat,

  /// A container with a glassmorphic style.
  glassmorphic,

  /// A container with a neumorphic style.
  neumorphic,

  /// A container with a neumorphic emboss style.
  neumorphicEmboss
}

/// A wrapper widget that provides a container with customizable properties.
///
/// The [ContainerWrapper] widget is used to wrap a child with a container.
/// It allows customization of props such as width, height, padding, decoration,
/// color, and borderRadius.
class ContainerWrapper extends StatelessWidget {
  /// Default constructor for [ContainerWrapper].
  const ContainerWrapper({
    required this.child,
    super.key,
    this.padding,
    this.hitTargetPadding,
    this.alignment,
    this.backgroundColor,
    this.borderRadius,
    this.width,
    this.height,
    this.decoration, // flat only
    this.type = ContainerType.flat,
    this.linearGradient, // glassmorphic only
    this.borderGradient, // glassmorphic only
    this.blur, // glassmorphic only
    this.border,
    this.onPressed,
  });

  /// The child widget to be wrapped by the container.
  final Widget child;

  /// The width of the container.
  final double? width;

  /// The height of the container.
  final double? height;

  /// The padding of the container.
  final EdgeInsets? padding;

  /// The hit target padding
  final EdgeInsets? hitTargetPadding;

  /// The alignment of the container.
  final Alignment? alignment;

  /// The decoration of the container.
  final BoxDecoration? decoration;

  /// The color of the container.
  final Color? backgroundColor;

  /// The border radius of the container.
  final BorderRadius? borderRadius;

  /// Container style type.
  final ContainerType type;

  /// The linear gradient of the glassmorphic container.
  final LinearGradient? linearGradient;

  /// The border gradient of the glassmorphic container.
  final LinearGradient? borderGradient;

  /// The blur of the glassmorphic container.
  final double? blur;

  /// The border of the glassmorphic container.
  final double? border;

  /// Onpress callback.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final content = switch (type) {
      ContainerType.flat => _flatStyleWrapper(child),
      ContainerType.glassmorphic => _glassmorphicStyleWrapper(child),
      ContainerType.neumorphic => _neumorphicWapper(child),
      ContainerType.neumorphicEmboss => _neumorphicEmbossWapper(child),
    };
    if (onPressed != null) {
      return CupertinoTheme(
        data: CupertinoThemeData(
          primaryColor: context
              .color.black, // This affects the default text color of button
        ),
        child: CupertinoButton(
          padding: hitTargetPadding ?? EdgeInsets.zero,
          onPressed: onPressed,
          child: content,
        ),
      );
    }
    return content;
  }

  /// Wraps the child widget with a container using the specified properties.
  ///
  /// The [child] widget is wrapped with a container that has the specified
  /// [width], [height], [padding], [decoration], [backgroundColor],
  /// and [borderRadius].
  Widget _flatStyleWrapper(Widget child) => Builder(
        builder: (context) {
          return Container(
            width: width,
            height: height,
            padding: padding,
            alignment: alignment,
            decoration: decoration ??
                BoxDecoration(
                  borderRadius: borderRadius,
                  color: backgroundColor,
                ),
            child: child,
          );
        },
      );

  /// Wraps the child widget with a glassmorphic container.
  Widget _glassmorphicStyleWrapper(Widget child) => Builder(
        builder: (context) {
          return IntrinsicHeight(
            child: Row(
              children: [
                GlassmorphicFlexContainer(
                  borderRadius: borderRadius?.topLeft.x ?? 0,
                  linearGradient: linearGradient ??
                      LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFFFFFFF).withValues(alpha: 0.1),
                          const Color(0xFFFFFFFF).withValues(alpha: 0.05),
                        ],
                        stops: const [
                          0.1,
                          1,
                        ],
                      ),
                  border: border ?? 0,
                  blur: blur ?? 0,
                  padding: EdgeInsets.zero,
                  borderGradient: borderGradient ??
                      LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFFFFFFF).withValues(alpha: 0.1),
                          const Color(0xFFFFFFFF).withValues(alpha: 0.05),
                          const Color(0xFFFFFFFF).withValues(alpha: 0.1),
                        ],
                      ),
                  child: Container(
                    width: width,
                    height: height,
                    padding: padding,
                    alignment: alignment,
                    child: child,
                  ),
                ),
              ],
            ),
          );
        },
      );

  Widget _neumorphicWapper(Widget child) => Builder(
        builder: (context) {
          return ClayContainer(
            width: width,
            height: height,
            color: backgroundColor,
            parentColor: backgroundColor,
            surfaceColor: backgroundColor,
            customBorderRadius: borderRadius,
            spread: 1,
            depth: 30,
            child: Container(
              padding: padding,
              alignment: alignment,
              child: child,
            ),
          );
        },
      );

  Widget _neumorphicEmbossWapper(Widget child) => Builder(
        builder: (context) {
          return ClayContainer(
            width: width,
            height: height,
            color: backgroundColor,
            parentColor: backgroundColor,
            surfaceColor: backgroundColor,
            customBorderRadius: borderRadius,
            spread: 1,
            depth: 50,
            emboss: true,
            child: Container(
              padding: padding,
              alignment: alignment,
              child: child,
            ),
          );
        },
      );
}
