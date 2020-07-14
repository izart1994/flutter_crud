import 'package:flutter/material.dart';
import 'package:flutter_crud/providers/student_providers.dart';
import 'package:flutter_crud/screens/add.dart';
import 'package:flutter_crud/screens/home.dart';
import 'package:flutter_crud/screens/student_detail.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: StudentProviders(),
        ),
      ],
      child: MaterialApp(
        title: 'AJAR CRUD API MYSQL',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
        routes: {
            Add.routeName: (context) => Add(),
            StudentDetail.routeName: (context) => StudentDetail(),
          },
      ),
    );
  }
}