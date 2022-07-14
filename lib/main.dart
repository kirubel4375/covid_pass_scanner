import 'package:covid_pass_scanner/Themes/theme_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screeens/Home/homepage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomeTheme.lightTheme,
      darkTheme: CustomeTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      home: const MyHomePage(),
    );
  }
}