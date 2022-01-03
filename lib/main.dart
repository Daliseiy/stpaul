import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stpaulanglicanchurh/screens/about/about.dart';
import 'package:stpaulanglicanchurh/screens/articles/article.dart';
import 'package:stpaulanglicanchurh/screens/form/burial.dart';
import 'package:stpaulanglicanchurh/screens/home/home.dart';
import 'package:stpaulanglicanchurh/screens/projects/projects.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'St Paul Anglican Church',
      theme: ThemeData(
        textTheme: GoogleFonts.andikaTextTheme(),
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (ctx) => BurialForm(),
        //'publications': (ctx) => Publications(),
        //'sermon': (ctx) => SermonScreen(),
        'about': (ctx) => AboutPage(),
        'projects': (ctx) => ProjectPage()
      },
    );
  }
}
