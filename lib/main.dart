import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/splash_screen/splash_screen.dart';

void main(){
  runApp(MYApp());
}

class MYApp extends StatelessWidget {
  const MYApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen(),);
  }
}