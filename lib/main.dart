import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytutor/models/user.dart';
import 'package:mytutor/views/loginscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Tutor',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        textTheme:
            GoogleFonts.anaheimTextTheme(Theme.of(context).textTheme.apply()),
      ),
      home: const SplashScreen(title: 'Mytutor'),
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
                image: AssetImage('assets/images/mytutor.jpeg'),
                fit: BoxFit.cover)),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("SlumShop",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber)),
                CircularProgressIndicator(),
                Text("Version 0.1",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ])),
    ]));
  }
}
