import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'Auth_Firebase/main_page.dart';
import 'constants.dart';
// import 'firebase_options.dart';
// import "package:firebase_core/firebase_core.dart";

import 'screens/main/main_screen.dart';

void main()  {
 // WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp(
  //    options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital Admin Panel',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home:  MainScreen(),
       // home:  MainPage(),

        initialRoute: '/',
    routes: {
      '/dashboard': (context) => MainScreen(),
    }
    );
  }
}
