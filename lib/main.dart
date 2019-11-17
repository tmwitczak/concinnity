// ////////////////////////////////////////////////////////////////// Imports //
import 'package:flutter/material.dart';
import 'package:inconcinnity/tabs/first.dart';
import 'package:inconcinnity/tabs/second.dart';
import 'package:inconcinnity/tabs/third.dart';
import 'package:inconcinnity/tabs/profile.dart';

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

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => MyHomeState();
}

// SingleTickerProviderStateMixin is used for animation
class MyHomeState extends State<MyHome> {
  int currentIndex = 0;
  List<Widget> tabs = [FirstTab(), SecondTab(), ThirdTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the TabBar view as the body of the Scaffold
      body: tabs[currentIndex],
      // Set the bottom navigation bar
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
