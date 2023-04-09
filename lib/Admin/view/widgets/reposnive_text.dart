import 'package:flutter/material.dart';
class ResponsiveText extends StatelessWidget {
  final Text child;
  const ResponsiveText({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: child,
    );
  }
}
