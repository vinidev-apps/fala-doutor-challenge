import 'package:flutter/material.dart';

class SignInIconButtonWidget extends StatefulWidget {
  final String imagePath;
  const SignInIconButtonWidget({super.key, required this.imagePath});

  @override
  State<SignInIconButtonWidget> createState() => _SignInIconButtonWidgetState();
}

class _SignInIconButtonWidgetState extends State<SignInIconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          border: BoxBorder.all(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Image.asset(
            widget.imagePath,
            height: 20,
            width: 20,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
