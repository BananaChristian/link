import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  final _lightTheme=ThemeData(
    colorScheme:const ColorScheme.light(
      surface:Colors.white,
      inverseSurface: Colors.black,
      primary:Colors.blue,
      secondary: Color.fromARGB(255, 165, 215, 228),
    )
  );

  final _darkTheme=ThemeData(
    colorScheme: const ColorScheme.dark(
      surface:Colors.black,
      inverseSurface: Colors.white,
      primary:Colors.blue,
      secondary:Color.fromARGB(255, 36, 38, 39),
    )
  );

  late ThemeData _currentTheme;

  ThemeProvider(){
    final Brightness systemBrightness=WidgetsBinding.instance.platformDispatcher.platformBrightness;
    _currentTheme=(systemBrightness==Brightness.dark)?_darkTheme:_lightTheme;
  }
  ThemeData get currentTheme => _currentTheme;
  
  void toggleThemes(){
    _currentTheme=(_currentTheme==_lightTheme)? _darkTheme:_lightTheme;
    notifyListeners();
  }
}