// ////////////////////////////////////////////////////////////////// Imports //
import 'package:flutter/material.dart';
import 'package:inconcinnity/home.dart';
import 'package:inconcinnity/workouts.dart';
import 'package:inconcinnity/exercises.dart';
import 'package:inconcinnity/profile.dart';

// ///////////////////////////////////////////////////////////////////// Main //
void main() => runApp(Inconcinnity());

// ///////////////////////////////////////////////////// Class | Inconcinnity //
class Inconcinnity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inconcinnity',
      home: MyHome(),
      theme: ThemeData(fontFamily: 'Livvic'),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ////////////////////////////////////////////////////////////////////////// //

// /////////////////////////////////////////////////// Class |  //
class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> {
  int currentIndex = 0;
  List<Widget> tabs = [HomeTab(), SecondTab(), ThirdTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int i) {
          setState(() {
            currentIndex = i;
          });
        },
        currentIndex: currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            title: Text("Workouts"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text("Exercises"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text("Profile"),
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontFamily: 'Livvic'),
        unselectedLabelStyle: TextStyle(fontFamily: 'Livvic'),
      ),
    );
  }
}
