import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
import 'package:stpaulanglicanchurh/providers/burial_provider.dart';
import 'package:stpaulanglicanchurh/screens/about/about.dart';
import 'package:stpaulanglicanchurh/screens/articles/article.dart';
import 'package:stpaulanglicanchurh/screens/form/burial.dart';
import 'package:stpaulanglicanchurh/screens/home/home.dart';
import 'package:stpaulanglicanchurh/screens/projects/projects.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: BurialProvider()),
      ],
      child: MaterialApp(
        title: 'St Paul Anglican Church',
        theme: ThemeData(
            textTheme: GoogleFonts.andikaTextTheme(),
            primarySwatch: Colors.blue,
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(
                    color: Color(0xff1d3557),
                  ),
                ),
              ),
            )),
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (ctx) => BurialForm(),
          //'publications': (ctx) => Publications(),
          //'sermon': (ctx) => SermonScreen(),
          'about': (ctx) => AboutPage(),
          'projects': (ctx) => ProjectPage()
        },
      ),
    );
  }
}
