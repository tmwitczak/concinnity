import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              Text('Jan Kowalski',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
              Container(height: 20, width: 10),
              Text(
                'Profile (in progress)',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
