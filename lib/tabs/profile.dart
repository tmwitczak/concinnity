import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text('Jan Kowalski',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
