import 'package:flutter/material.dart';

import 'package:test_tecn/src/pages/home_page.dart';
import 'package:test_tecn/src/pages/index_page.dart';
import 'package:test_tecn/src/pages/islas_page.dart'; 

Map<String,WidgetBuilder> getApplicationRoutes(){
  return <String,WidgetBuilder>{
    //PAGINAS PRINCIPALES
    'home'         : (BuildContext context) => const HomePage(),   
    'islas'        : (BuildContext context) => const IslasPage(),   
    'index'        : (BuildContext context) => const IndexPage(),  
  };
}