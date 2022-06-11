import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytutor/views/loginscreen.dart';
import '../constants.dart';
import '../models/course.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'tutorscreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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

  void _onItemTapped(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }

  List<Course> courseList = <Course>[];
  late double screenHeight, screenWidth, resWidth;
  String titlecenter = "No Course Available";
  var _tapPosition;
  var numofpage, curpage = 1;
  var color;

  TextEditingController searchController = TextEditingController();
  String search = "";

  @override
  void initState() {
    super.initState();
    _loadSubjects(1);
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
            icon: Icon(Icons.subject),
            label: 'Subjects',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Tutors',
            backgroundColor: Colors.green,
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
      body: courseList.isEmpty
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
                      children: List.generate(courseList.length, (index) {
                        return Card(
                            child: Column(
                          children: [
                            Flexible(
                              flex: 6,
                              child: CachedNetworkImage(
                                imageUrl: CONSTANTS.server +
                                    "/mytutor/php_folder/assets/courses/" +
                                    courseList[index].subject_id.toString() +
                                    '.png',
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
                                      courseList[index].subject_name.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("RM " +
                                        double.parse(courseList[index]
                                                .subject_price
                                                .toString())
                                            .toStringAsFixed(2)),
                                    Text("Session: " +
                                        courseList[index]
                                            .subject_sessions
                                            .toString()),
                                  ],
                                )),
                          ],
                        ));
                      }))),
              // SizedBox(
              //   height: 30,
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: numofpage,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) {
              //       if ((curpage - 1) == index) {
              //         color = Colors.red;
              //       } else {
              //         color = Colors.black;
              //       }
              //       return SizedBox(
              //         width: 40,
              //         child: TextButton(
              //             onPressed: () => {_loadSubjects(index + 1)},
              //             child: Text(
              //               (index + 1).toString(),
              //               style: TextStyle(color: color),
              //             )),
              //       );
              //     },
              //   ),
              // ),
            ]),
    );
  }

  void _loadSubjects(int pageno) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/php_folder/php/loadcourse.php"),
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

        if (getdata['courses'] != null) {
          courseList = <Course>[];
          getdata['courses'].forEach((v) {
            courseList.add(Course.fromJson(v));
          });
          titlecenter = courseList.length.toString() + " Courses Available";
        } else {
          titlecenter = "No Course Available";
          courseList.clear();
        }
        setState(() {});
      } else {
        titlecenter = "No Course Available";
        courseList.clear();
        setState(() {});
      }
    });
  }
}
