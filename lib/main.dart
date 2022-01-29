import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stpaulanglicanchurh/providers/data_provider.dart';
import 'package:stpaulanglicanchurh/routes/pages.dart';
import 'package:stpaulanglicanchurh/screens/dashboard/dashboard.dart';
import 'package:stpaulanglicanchurh/screens/dashboard/screens/burials.dart';
import 'package:stpaulanglicanchurh/screens/dashboard/screens/contacts.dart';
import 'package:stpaulanglicanchurh/screens/dashboard/screens/event.dart';
import 'package:stpaulanglicanchurh/screens/dashboard/screens/occasions.dart';
import 'package:stpaulanglicanchurh/screens/dashboard/screens/testimony.dart';
import 'firebase_options.dart';
import 'package:stpaulanglicanchurh/providers/burial_provider.dart';
import 'package:stpaulanglicanchurh/screens/about/about.dart';
import 'package:stpaulanglicanchurh/screens/home/home.dart';
import 'package:stpaulanglicanchurh/screens/projects/projects.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor:
            Colors.blue.shade900, //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness: Brightness.light));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: BurialProvider(),
        ),
        ChangeNotifierProvider.value(value: DataProvider()),
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
        //getPages: AppPages.routes,
        routes: {
          'home': (ctx) => DashBoard(),
          //'publications': (ctx) => Publications(),
          //'sermon': (ctx) => SermonScreen(),
          'about': (ctx) => AboutPage(),
          'give': (ctx) => ProjectPage(),
          'testimony-admin': (ctx) => TestimonyScreen(),
          'event-admin': (ctx) => EventScreen(),
          'contact-admin': (ctx) => ContactScreen(),
          'burial-admin': (ctx) => BurialsScreen(),
          'occassion-admin': (ctx) => OccasionScreen(),
        },
      ),
    );
  }
}
