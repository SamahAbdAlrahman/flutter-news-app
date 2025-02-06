import 'package:flutter/material.dart';
import 'package:news/screens/updateData.dart';

import 'screens/home.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      // home: update(),
      home: MyApp(),
    ),
  );}
