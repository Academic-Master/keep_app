import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  late final String label;
  late final void Function() onPressed;
  late final bool isSelected;
  late final bool withShadow;
  final Color _color = Color(0xFF5669ff);

  CustomButton(
      {required this.withShadow,
      required this.isSelected,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: this.withShadow
              ? [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 3,
                      offset: Offset(0, 1))
                ]
              : []),
      child: TextButton(
        onPressed: this.isSelected ? this.onPressed : () {},
        child: Text(
          this.label,
          style: TextStyle(color: Colors.white),
        ),
        style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            padding: const EdgeInsets.symmetric(vertical: 20),
            backgroundColor: !this.isSelected ? Colors.grey.shade200 : _color),
      ),
    );
  }
}
