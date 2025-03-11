import 'package:flutter/material.dart';

class CustomFields extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Color color;
  final bool obscureText;
  const CustomFields({super.key, required this.controller, required this.hintText, required this.color, required this.obscureText});

  @override
  State<CustomFields> createState() => _CustomFieldsState();
}

class _CustomFieldsState extends State<CustomFields> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration:InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color:widget.color
        ),
        border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: widget.color)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color:widget.color)
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color:widget.color)
        ),
      ),
    );
  }
}