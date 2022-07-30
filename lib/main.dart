import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:test_tecn/src/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid){
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown, 
      ]);
    }
    return MaterialApp(
      title: 'Prueba técnica',
      theme: ThemeData(  
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[100],
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          toolbarTextStyle: const TextStyle(
            color: Colors.black,
          ) 
        ), 
        fontFamily: 'Futura'
      ),
      debugShowCheckedModeBanner: false,
      routes: getApplicationRoutes(), 
      initialRoute: 'home', 
    );
  }
}
