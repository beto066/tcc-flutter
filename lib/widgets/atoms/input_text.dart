import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String label;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? focusedBorder;
  final FocusNode? focusNode;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final bool obscureText;
  final double fontSize;

  const InputText(this.label, {
    super.key,
    required this.validator,
    required this.controller,
    this.enabledBorder,
    this.focusedBorder,
    this.focusNode,
    this.height,
    this.width,
    this.onTap,
    this.keyboardType,
    this.obscureText = false,
    this.fontSize = 14,
  });

  @override
  State<StatefulWidget> createState() {
    return _InputTextState();
  }
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        obscureText: widget.obscureText,
        style: TextStyle(
          fontSize: widget.fontSize,
        ),
        decoration: InputDecoration(
          labelText: widget.label,
          fillColor: Colors.lightBlue[50],
          filled: true,
          floatingLabelStyle: const TextStyle(
            color: Color(0xFF7A8CBA),
          ),

          border: widget.enabledBorder ?? OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFDEE2E3)),
            borderRadius: BorderRadius.circular(30.0),
          ),

          focusedBorder: widget.focusedBorder ?? OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF7A8CBA)),
            borderRadius: BorderRadius.circular(30.0),
          ),

          enabledBorder: widget.enabledBorder ?? OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFBEC2C3)),
            borderRadius: BorderRadius.circular(30.0),
          ),

          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 20.0,
          ),
        ),

        onTap: widget.onTap,
        validator: widget.validator,
      ),
    );
  }
}