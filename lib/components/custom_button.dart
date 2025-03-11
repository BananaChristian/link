import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Color backgroundColor;
  final String buttonText;
  final VoidCallback onTap;
  const CustomButton({super.key, required this.backgroundColor, required this.buttonText, required this.onTap});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onTap,
      child: Container(
        padding:const EdgeInsets.all(10),
        decoration:BoxDecoration(
          color:widget.backgroundColor,
          borderRadius: BorderRadius.circular(10)
        ),
        width:double.infinity,
        child:Center(child: Text(widget.buttonText))
      ),
    );
  }
}