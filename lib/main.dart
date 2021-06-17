import 'package:client/Views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tandoor Hut',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryTextTheme:
              GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                  .copyWith(
                      bodyText1: GoogleFonts.poppins(color: Colors.white),
                      bodyText2: GoogleFonts.poppins(color: Colors.white),
                      headline2: GoogleFonts.lato(color: Colors.white),
                      headline3: GoogleFonts.lato(color: Colors.white),
                      headline4: GoogleFonts.lato(color: Colors.white),
                      headline5: GoogleFonts.lato(color: Colors.white),
                      headline6: GoogleFonts.lato(color: Colors.white),
                      subtitle1: GoogleFonts.poppins(color: Colors.white),
                      subtitle2: GoogleFonts.poppins(color: Colors.white),
                      button: GoogleFonts.poppins(color: Colors.white),
                      caption: GoogleFonts.poppins(color: Colors.white))),
      home: SplashScreen(),
    );
  }
}
