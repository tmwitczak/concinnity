import 'package:flutter/material.dart';

class SecondTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              // center the children
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Workouts (in progress)",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
