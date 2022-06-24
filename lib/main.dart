import 'dart:async';
import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytutor/models/user.dart';
import 'package:mytutor/views/loginscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user;
    return MaterialApp(
      title: 'My Tutor',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        textTheme:
            GoogleFonts.anaheimTextTheme(Theme.of(context).textTheme.apply()),
      ),
      home: SplashScreen(title: 'Mytutor'),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required String title}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.center, children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/mytutor.png'),
                fit: BoxFit.cover)),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("MY Tutor",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 130, 106, 106),
                        fontFamily: "Pacifico")),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 7, 42, 104)),
                ),
                Text("Version 10.0",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ])),
    ]));
  }
}
