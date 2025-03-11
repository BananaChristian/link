import 'package:flutter/material.dart';
import 'package:link/pages/auth_pages/login_page.dart';
import 'package:link/services/auth/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService=AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body:SafeArea(
        child: Container(
          padding:const EdgeInsets.all(10),
          child: Column(
            children:[
              GestureDetector(
                onTap:()async{
                  final logout=await _authService.logOut();
                  final isLoggedOut=logout==await _authService.logOut();
                  if(isLoggedOut==true){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> const LoginPage())
                    );
                  }
                },
                child: const ListTile(
                  leading:Icon(Icons.logout),
                  title:Text('Log out')
                ),
              ),
              const SizedBox(height:10),
              GestureDetector(
                onTap:(){},
                child: const ListTile(
                  leading:Icon(Icons.delete,color:Colors.red),
                  title:Text('Delete',style:TextStyle(color:Colors.red))
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}