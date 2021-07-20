import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class CustomTextField extends StatelessWidget {
  late final bool isObscure;
  late final String label;
  late final IconData icon;
  late final TextEditingController inputController;
  //TODO change to enum later
  late final String fieldType;
  final Color _color = Color(0xFFffb151);

  CustomTextField(
      {required this.label,
      required this.fieldType,
      required this.icon,
      this.isObscure: false,
      required this.inputController});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          this.label,
          style: TextStyle(
              color: _color, fontSize: 14, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 7,
        ),
        Container(
          child: TextFormField(
            validator: (value) => value!.isNotEmpty
                ? !isEmail(value) && this.fieldType == 'email'
                    ? 'Entrer a valid ${this.label}'
                    : null
                : 'Field this field',
            controller: this.inputController,
            obscureText: this.isObscure,
            keyboardType: textFieldType,
            decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Icon(this.icon, color: _color),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(50),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.5, color: Colors.red),
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.5, color: _color),
                  borderRadius: BorderRadius.circular(50),
                )),
          ),
        ),
      ],
    );
  }

  TextInputType get textFieldType {
    switch (this.fieldType) {
      case 'text':
        return TextInputType.text;
      case 'email':
        return TextInputType.emailAddress;
      case 'phone':
        return TextInputType.phone;
    }
    return TextInputType.text;
  }
}
