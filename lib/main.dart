import 'package:distribution/routes.dart';
import 'package:distribution/src/providers/bottom_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomProvider()),
      ],
      child: MyApp(),
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
      debugShowCheckedModeBanner: false,
      title: 'Distribution',
      theme: ThemeData(
        primaryColor: Color(0xfff4b93f),
        primaryColorLight: Color(0xffECE7DD),
        primaryColorDark: Color(0xfff4b93f),
        scaffoldBackgroundColor: Color(0xFFF8F8FA),
        textTheme:
            GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).copyWith(
          displayLarge: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          displayMedium: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          displaySmall: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          headlineLarge: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          headlineMedium: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          headlineSmall: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          titleLarge: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          titleMedium: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          titleSmall: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          labelLarge: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          labelMedium: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          labelSmall: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      initialRoute: Routes.splash,
      routes: Routes.routes,
    );
  }
}
