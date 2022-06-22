import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../constants.dart';

class RegisScreen extends StatefulWidget {
  const RegisScreen({Key? key}) : super(key: key);

  @override
  State<RegisScreen> createState() => _RegisScreenState();
}

class _RegisScreenState extends State<RegisScreen> {
  late double screenHeight, screenWidth, ctrwidth;
  String pathAsset = 'assets/images/camera.png';
  var _image;
  bool remember = false;
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController password2Ctrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 800) {
      ctrwidth = screenWidth / 1.5;
    }
    if (screenWidth < 800) {
      ctrwidth = screenWidth / 1.1;
    }
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: SizedBox(
                    width: ctrwidth,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Card(
                            elevation: 10,
                            child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 30, 20, 15),
                                child: Column(children: <Widget>[
                                  GestureDetector(
                                      onTap: () => {_takePictureDialog()},
                                      child: SizedBox(
                                          height: screenHeight / 2.5,
                                          width: screenWidth,
                                          child: _image == null
                                              ? Image.asset(pathAsset)
                                              : Image.file(
                                                  _image,
                                                  fit: BoxFit.cover,
                                                ))),
                                  TextFormField(
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (v) {
                                        FocusScope.of(context)
                                            .requestFocus(focus);
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
                                        FocusScope.of(context)
                                            .requestFocus(focus1);
                                      },
                                      controller: emailCtrl,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          labelText: 'Email',
                                          labelStyle: TextStyle(),
                                          icon: Icon(Icons.email),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 2.0),
                                          ))),
                                  TextFormField(
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (v) {
                                        FocusScope.of(context)
                                            .requestFocus(focus2);
                                      },
                                      controller: phoneCtrl,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          labelText: 'Phone Number',
                                          labelStyle: TextStyle(),
                                          icon: Icon(Icons.phone),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 2.0),
                                          ))),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(focus3);
                                    },
                                    controller: passwordCtrl,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: TextStyle(),
                                        icon: Icon(Icons.lock),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2.0),
                                        )),
                                    obscureText: true,
                                  ),
                                  TextFormField(
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(focus4);
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
                                  TextFormField(
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (v) {
                                        FocusScope.of(context)
                                            .requestFocus(focus5);
                                      },
                                      controller: addressCtrl,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          labelText: 'Address',
                                          labelStyle: TextStyle(),
                                          icon: Icon(Icons.home_filled),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 2.0),
                                          ))),
                                ])),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                              width: screenWidth,
                              height: 50,
                              child: ElevatedButton(
                                child: const Text("Enter"),
                                onPressed: () {
                                  _insertDialog();
                                },
                              ))
                        ],
                      ),
                    )))));
  }

  _takePictureDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text(
                "Select from",
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                      onPressed: () => {
                            Navigator.of(context).pop(),
                            _galleryPicker(),
                          },
                      icon: const Icon(Icons.browse_gallery),
                      label: const Text("Gallery")),
                  TextButton.icon(
                      onPressed: () =>
                          {Navigator.of(context).pop(), _cameraPicker()},
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Camera")),
                ],
              ));
        });
  }

  _galleryPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    }
  }

  _cameraPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    }
  }

  Future<void> _cropImage() async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _insertDialog() {
    if (_formKey.currentState!.validate() && _image != null) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Add this user",
              style: TextStyle(),
            ),
            content: const Text("Are you sure?", style: TextStyle()),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _insertUser();
                },
              ),
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _insertUser() {
    String _username = nameCtrl.text;
    String _useremail = emailCtrl.text;
    String _userphone = phoneCtrl.text;
    String _userpassword = passwordCtrl.text;
    String _userpassword2 = password2Ctrl.text;
    String _useraddress = addressCtrl.text;
    String base64Image = base64Encode(_image!.readAsBytesSync());
    http.post(Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/new_user.php"),
        body: {
          "name": _username,
          "email": _useremail,
          "phone": _userphone,
          "password": _userpassword,
          "password2": _userpassword2,
          "address": _useraddress,
          "image": base64Image,
        }).then((response) {
      print(response.body);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Register Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
            msg: data['Failed'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }
}
