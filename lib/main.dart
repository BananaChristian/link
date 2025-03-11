import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:link/firebase_options.dart';
import 'package:link/pages/auth_pages/register_page.dart';
import 'package:link/theme/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options:DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_)=>ThemeProvider(),
      child:const MyApp(),
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:themeProvider.currentTheme,
      home:const RegisterPage()
    );
  }
}