import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(Registerpage());

class Registerpage extends StatefulWidget {
  const Registerpage({Key? key}) : super(key: key);

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final _formKey = GlobalKey<FormState>();
  late double screenHeight, screenWidth;
  bool remember = false;
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController password2Ctrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    Widget uppperHalf(BuildContext context) {
      return SizedBox(
          height: screenHeight / 2,
          width: screenWidth,
          child: Image.asset(
            'assets/images/login.png',
            fit: BoxFit.cover,
          ));
    }

    Widget lowerHalf(BuildContext context) {
      return Container(
          height: 600,
          margin: EdgeInsets.only(top: screenHeight / 5),
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Card(
                  elevation: 10,
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(25, 10, 20, 25),
                      child: Column(children: <Widget>[
                        //Form regsitration here
                      ])))
            ],
          )));
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus);
                    },
                    controller: nameCtrl,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(),
                        icon: Icon(Icons.person),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ))),
                TextFormField(
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus1);
                    },
                    controller: emailCtrl,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(),
                        icon: Icon(Icons.phone),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ))),
                TextFormField(
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus2);
                    },
                    controller: passwordCtrl,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(),
                        icon: Icon(Icons.lock),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ))),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  focusNode: focus2,
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(focus3);
                  },
                  controller: password2Ctrl,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: 'Re-enter Password',
                      labelStyle: TextStyle(),
                      icon: Icon(Icons.lock),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      )),
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });

                            Children:
                            [uppperHalf(context), lowerHalf(context)];
                          }),
                      Flexible(
                        child: GestureDetector(
                          onTap: null,
                          child: const Text('Agree with terms',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 115,
                        height: 50,
                        child: const Text('Register'),
                        elevation: 10,
                        onPressed: _registerAccount,
                      ),
                    ]),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  void _registerAccount() {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please complete the registration form first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    if (!_isChecked) {
      Fluttertoast.showToast(
          msg: "Please accept the terms and conditions",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
  }
}
