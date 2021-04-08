import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/home.dart';

class SpleshScreen extends StatefulWidget {
  @override
  _SpleshScreenState createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      ()=> Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Home(),
        )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
            Text("My",
              style: TextStyle(
                color: Colors.green[400],
                fontSize: 35,
                fontWeight: FontWeight.w500
              ),
            ),
            Text("Wallpaper", 
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.w500
              ),
            ),
            Text("App", 
              style: TextStyle(
                color: Colors.green[400],
                fontSize: 35,
                fontWeight: FontWeight.w500 
              ),
            )
          ],
        ),
      ),
    );
  }
}