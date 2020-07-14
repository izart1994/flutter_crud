import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_crud/models/student_model.dart';

class StudentProviders with ChangeNotifier {
  String _state;
  String _detail;

  List<StudentModel> _items = [];

  List<StudentModel> get items {
    return _items;
  }

  String get state {
    return _state;
  }

  String get detail {
    return _detail;
  }

  Future<void> fetchStudent() async {
    // var url = 'https://flutter.otaiwebsite.com/api/crud/show.php';
    //var url = 'http://10.0.2.2/api/crud/show.php';

    final response = await http.get(new Uri.http("10.0.2.2", "api/show.php"));
    final extractedData = json.decode(response.body) as List<dynamic>;
    final List<StudentModel> loadedData = [];
    if (extractedData == null) {
      return;
    }
    extractedData.forEach(
      (controlData) {
        loadedData.add(
          StudentModel(
            id: controlData['id'],
            name: controlData['name'],
            age: controlData['age'],
          ),
        );

        _items = loadedData;
        notifyListeners();
      },
    );
  }

  Future<void> addStudent(StudentModel student) async {
    // final url = 'https://flutter.otaiwebsite.com/api/crud/add.php';
    try {
      final response = await http.post(
        new Uri.http("10.0.2.2", "api/add.php"),
        body: json.encode(
          {
            'name': student.name,
            'age': student.age,
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = json.decode(response.body);
      print(responseData);

      _state = responseData['state'];
      _detail = responseData['detail'];

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateStudent(String id, String name, String age) async {
    final Map<String, dynamic> authData = {
      'id': id,
      'name': name,
      'age': age,
    };
    print(authData);

    try {
      //dynamic url = 'https://flutter.otaiwebsite.com/api/crud/edit.php';
      final response = await http.post(
        new Uri.http("10.0.2.2", "api/edit.php"),
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = json.decode(response.body);
      print(responseData);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> deleteStudent(String id) async {
    final Map<String, dynamic> authData = {
      'id': id,
    };

    try {
      // dynamic url = 'https://flutter.otaiwebsite.com/api/crud/delete.php';
      final response = await http.post(
        new Uri.http("10.0.2.2", "api/delete.php"),
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = json.decode(response.body);
      print(responseData);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
