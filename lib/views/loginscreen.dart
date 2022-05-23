import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mytutor/views/regisscreen.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double screenHeight, screenWidth;
  bool remember = false;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: screenHeight / 2.5,
                      width: screenWidth,
                      child: Image.asset('assets/images/logo.png')),
                  const Text("Login My TuTor App",
                      style: TextStyle(fontSize: 24)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      controller: emailCtrl,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: TextField(
                        controller: passwordCtrl,
                        decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      )),
                  Row(
                    children: [
                      Checkbox(value: remember, onChanged: _OnRememberMe),
                      const Text("Remember Me")
                    ],
                  ),
                  SizedBox(
                      child: ElevatedButton(
                    child: const Text("Login"),
                    onPressed: _loginUser,
                  )),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    minWidth: 115,
                    height: 50,
                    child: const Text("Sign Up",
                        style: TextStyle(decoration: TextDecoration.underline)),
                    elevation: 10,
                    onPressed: _registerAccount,
                  ),
                ]))
      ]),
    ));
  }

  void _OnRememberMe(bool? value) {
    setState(() {
      remember = value!;
    });
  }

  void _loginUser() {
    String _email = emailCtrl.text;
    String _password = passwordCtrl.text;
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.post(Uri.parse(CONSTANTS.server + "/mytutor/php/new_user.php"),
          body: {"email": _email, "password": _password}).then((response) {
        print(response.body);
        if (response.body == "Success") {
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (content) => const RegisterPage()));
        } else {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        }
      });
    }
  }

  void _registerAccount() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: const Text("Register new Account", style: TextStyle()),
              content: const Text("Are you sure?", style: TextStyle()),
              actions: <Widget>[
                TextButton(
                    child: const Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const RegisScreen()));
                    }),
                TextButton(
                    child: const Text(
                      "No",
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ]);
        });
  }
}
