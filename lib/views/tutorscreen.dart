import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/tutor.dart';
import 'mainscreen.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({Key? key}) : super(key: key);

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  var _tapPosition;
  var numofpage, curpage = 1;
  var color;
  List<Tutor> tutorList = <Tutor>[];
  String titlecenter = "No Tutors Available";
  late double screenHeight, screenWidth, resWidth;

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MainScreen(),
    TutorScreen(),
    MainScreen(),
    MainScreen(),
    MainScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTutors(1);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      //rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      //rowcount = 3;
    }

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Tutors',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.subject),
              label: 'Subjects',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face),
              label: 'Subscribe',
              backgroundColor: Colors.purple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'Favourite',
              backgroundColor: Colors.pink,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.blue,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
        body: tutorList.isEmpty
            ? Center(
                child: Text(titlecenter,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)))
            : Column(children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text("Courses Available",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                    child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: (1 / 1),
                        children: List.generate(tutorList.length, (index) {
                          return Card(
                              child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  imageUrl: CONSTANTS.server +
                                      "/mytutor/php_folder/assets/tutors/" +
                                      tutorList[index].tutor_id.toString() +
                                      '.jpg',
                                  fit: BoxFit.cover,
                                  width: resWidth,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Flexible(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Text(
                                        tutorList[index].tutor_name.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("Subject " +
                                          tutorList[index]
                                              .tutor_name
                                              .toString()),
                                      Text("Phone no." +
                                          tutorList[index]
                                              .tutor_phone
                                              .toString()),
                                    ],
                                  )),
                            ],
                          ));
                        }))),
              ]));
  }

  void _loadTutors(int pageno) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/php_folder/php/loadtutor.php"),
        body: {}).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var getdata = jsondata['data'];
        // numofpage = int.parse(jsondata['numofpage']);

        if (getdata['tutors'] != null) {
          tutorList = <Tutor>[];
          getdata['tutors'].forEach((v) {
            tutorList.add(Tutor.fromJson(v));
          });
          titlecenter = tutorList.length.toString() + " Courses Available";
        } else {
          titlecenter = "No Course Available";
          tutorList.clear();
        }
        setState(() {});
      } else {
        titlecenter = "No Course Available";
        tutorList.clear();
        setState(() {});
      }
    });
  }
}
