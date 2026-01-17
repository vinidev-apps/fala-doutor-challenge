import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DefaultRoundedIconButtonWidget extends StatefulWidget {
  final IconData iconData;
  final void Function() onTap;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? iconColor;

  const DefaultRoundedIconButtonWidget({
    super.key,
    required this.iconData,
    required this.onTap,
    this.height,
    this.width,
    this.borderRadius,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  State<DefaultRoundedIconButtonWidget> createState() =>
      _DefaultRoundedIconButtonWidgetState();
}

class _DefaultRoundedIconButtonWidgetState
    extends State<DefaultRoundedIconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      splashColor: Colors.transparent,
      child: Container(
        height: widget.height ?? 50,
        width: widget.width ?? 50,
        decoration: BoxDecoration(
          color:
              widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: FaIcon(
            widget.iconData,
            color:
                widget.iconColor ?? Theme.of(context).colorScheme.onBackground,
            size: 15,
          ),
        ),
      ),
    );
  }
}
