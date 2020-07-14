import 'package:flutter/material.dart';

class StudentDetail extends StatefulWidget {
  static const routeName = '/studentdetail';

  @override
  _StudentDetailState createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
      ),
    );
  }
}
