import 'package:flutter/material.dart';

class buyItemField extends StatelessWidget {
  final String fieldText;
  final Color fieldTextColor;
  final bool editAble;
  final double textSize;
  final bool hideInput;
  final TextInputType textType;
  final TextEditingController? fieldController;

  buyItemField({
    required this.fieldText,
    required this.fieldTextColor,
    required this.textSize,
    required this.hideInput,
    required this.textType,
    required this.editAble,
    this.fieldController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: fieldController,
      enabled: editAble,
      obscureText: hideInput,
      keyboardType: textType,
      decoration: InputDecoration(
        hintText: fieldText,
        hintStyle: TextStyle(
          color: fieldTextColor,
          fontSize: textSize,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
      ),
    );
  }
}
