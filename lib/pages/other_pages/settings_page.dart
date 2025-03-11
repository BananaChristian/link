import 'package:flutter/material.dart';
import 'package:link/pages/other_pages/profile_page.dart';
import 'package:link/theme/theme.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body:SafeArea(
        child: Container(
          padding:const EdgeInsets.all(10),
          child:Column(
            children:[
              //Access to the profile page
              GestureDetector(
                onTap:(){
                  showModalBottomSheet(
                    context: context, 
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)
                      )
                    ),
                    builder: (context)=> const ProfilePage()
                  );
                },
                child: Card(
                  color:Theme.of(context).colorScheme.secondary,
                  elevation: 0.8,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading:CircleAvatar(
                        child:Icon(Icons.person)
                      ),
                      title:Text('Profile'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height:10),
              //Toggle themes
              GestureDetector(
                onTap:(){
                  themeProvider.toggleThemes();
                },
                child: const ListTile(
                  title:Text('Switch modes'),
                  leading: Icon(Icons.brightness_6)
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}