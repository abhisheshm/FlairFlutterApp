

import 'package:flair_app/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuditoriumList extends StatefulWidget {
  @override
  _AuditoriumListState createState() => _AuditoriumListState();
}

class _AuditoriumListState extends State<AuditoriumList> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(87, 144, 223, 1),
      /* appBar: AppBar(
        title: const Text("Login Page"),
      ),*/
      body: Center(child: Text("Auditorium"),),
    );
  }
}