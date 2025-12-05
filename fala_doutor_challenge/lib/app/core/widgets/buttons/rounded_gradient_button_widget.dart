import 'package:flutter/material.dart';

class GradientTextButtonWidget extends StatefulWidget {
  final String labelText;
  final void Function() onTap;
  final double? height;
  final double? width;
  final List<Color>? gradientColors;
  final Color? textColor;
  final TextStyle? labelTextStyle;
  const GradientTextButtonWidget({
    super.key,
    required this.labelText,
    required this.onTap,
    this.height,
    this.width,
    this.gradientColors,
    this.textColor,
    this.labelTextStyle,
  });

  @override
  State<GradientTextButtonWidget> createState() =>
      _GradientTextButtonWidgetState();
}

class _GradientTextButtonWidgetState extends State<GradientTextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Container(
        height: widget.height ?? 50,
        width: widget.width ?? double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors:
                widget.gradientColors ??
                [
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.tertiary,
                ],
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            widget.labelText.toLowerCase(),
            style: widget.labelTextStyle ?? Theme.of(context).textTheme.labelLarge?.copyWith(
              color:
                  widget.textColor ?? Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
