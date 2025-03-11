import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  final String username;
  final Color backgroundColor;
  final VoidCallback onTap;
  const UserList({super.key, required this.username, required this.backgroundColor, required this.onTap});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding:const EdgeInsets.all(10),
        width:double.infinity,
        decoration:BoxDecoration(
          color: widget.backgroundColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10)
        ),
        child:Row(
          children:[
            const CircleAvatar(
              child:Icon(Icons.person)
            ),
            const SizedBox(width:50),
            Column(
              children: [
                Text(widget.username),
              ],
            ),
          ]
        ),
      ),
    );
  }
}