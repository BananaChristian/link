import 'package:flutter/material.dart';
import 'package:link/pages/other_pages/calls_page.dart';
import 'package:link/pages/other_pages/groups_page.dart';
import 'package:link/pages/other_pages/home_page.dart';
import 'package:link/pages/other_pages/settings_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final pages=[
    const HomePage(),
    const GroupsPage(),
    const CallsPage(),
    const SettingsPage()
  ];

  int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        elevation: 1,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor:Theme.of(context).colorScheme.inverseSurface,
        onTap:(index){
          setState((){
            _currentIndex=index;
          });
        },
        items:const  [
          BottomNavigationBarItem(icon: Icon(Icons.chat),label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.groups),label:'Groups'),
          BottomNavigationBarItem(icon: Icon(Icons.phone),label:'Calls'),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label:'Settings'),
        ]
      ),
    );
  }
}