import 'package:flutter/material.dart';

class authLoginField extends StatefulWidget {
  final IconData fieldIcon;
  final String fieldText;
  final Color iconAndTextColor;
  final double iconSize;
  final double textSize;
  final bool hideInput;
  final TextEditingController fieldController;
  final TextInputType textType;
  final IconData? fieldIcon2;

  authLoginField({
    required this.fieldIcon,
    required this.fieldText,
    required this.iconAndTextColor,
    required this.iconSize,
    required this.textSize,
    required this.hideInput,
    required this.textType,
    required this.fieldController,
    this.fieldIcon2,
  });

  @override
  State<authLoginField> createState() => _authLoginFieldState();
}

class _authLoginFieldState extends State<authLoginField> {
  bool ispasswordNotVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableSuggestions: true,
      obscureText: widget.fieldText == "Enter your password" ||
              widget.fieldText == "Confirm Password"
          ? ispasswordNotVisible
          : widget.hideInput,
      keyboardType: widget.textType,
      controller: widget.fieldController,
      decoration: InputDecoration(
        suffixIcon: widget.fieldText == "Enter your password" ||
                widget.fieldText == "Confirm Password"
            ? IconButton(
                onPressed: () {
                  setState(() {
                    ispasswordNotVisible = !ispasswordNotVisible;
                  });
                },
                color: ispasswordNotVisible
                    ? widget.iconAndTextColor
                    : Colors.blue,
                icon: Icon(
                  ispasswordNotVisible ? widget.fieldIcon2 : Icons.visibility,
                ),
              )
            : null,
        prefixIcon: Icon(
          widget.fieldIcon,
          color: widget.iconAndTextColor,
          size: widget.iconSize,
        ),
        hintText: widget.fieldText,
        hintStyle: TextStyle(
          color: widget.iconAndTextColor,
          fontSize: widget.textSize,
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
