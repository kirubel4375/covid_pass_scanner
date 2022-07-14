import 'package:flutter/material.dart';


CustomeTheme currentTheme = CustomeTheme();
class CustomeTheme extends ChangeNotifier{

  bool _isDarkTheme = true;

  ThemeMode get currentTheme => _isDarkTheme? ThemeMode.dark: ThemeMode.light;

  void toggleTheme(){
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme{
  return ThemeData.dark().copyWith(
    elevatedButtonTheme:  ElevatedButtonThemeData(
      style: const ButtonStyle().copyWith(
        textStyle:MaterialStateProperty.resolveWith<TextStyle?>((_) {
          return const TextStyle(
            color: Colors.black,
          );
        } ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>((_) {
          return const Color.fromARGB(255, 255, 60, 0);
        } ),
        shape:  MaterialStateProperty.resolveWith<OutlinedBorder?>((_) {
          return const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            side: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          );
        } )
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: const ButtonStyle().copyWith(
        textStyle:MaterialStateProperty.resolveWith<TextStyle?>((_) {
          return const TextStyle(
            color: Color.fromARGB(255, 255, 60, 0),
          );
        } ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: const ButtonStyle().copyWith(
        textStyle:MaterialStateProperty.resolveWith<TextStyle?>((_) {
          return const TextStyle(
            color: Color.fromARGB(255, 255, 60, 0),
          );
        } ),
        side: MaterialStateProperty.resolveWith<BorderSide?>((_) {
          return const BorderSide(
            color: Colors.blue,
            width: 3.0,
          );
        } ),
      ),
    ),
  );
  }

  static ThemeData get darkTheme{
    return ThemeData.light().copyWith(

    );
  }

}