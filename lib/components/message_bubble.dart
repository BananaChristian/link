import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  final String message;
  final Color bubbleColor;
  final Alignment alignment;
  const MessageBubble({super.key, required this.message, required this.bubbleColor, required this.alignment});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: Container(
        padding:const EdgeInsets.all(8),
        margin:const EdgeInsets.symmetric(vertical:5,horizontal: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width*0.5
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:widget.bubbleColor
        ),
        child:ListTile(
          title: Text(widget.message),
        ),
      ),
    );
  }
}