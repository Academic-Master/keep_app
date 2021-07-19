import 'package:flutter/material.dart';

class CustomRoundedContainer extends StatelessWidget {
  late final Widget child;
  late final Color? color;
  CustomRoundedContainer({this.color, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(5),
      child: this.child,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: this.color ?? Colors.grey.shade100),
    );
  }
}
