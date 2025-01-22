import 'package:flutter/material.dart';
import 'package:flutter_app/network.dart';

class stateController with ChangeNotifier {
  List<Course> courses = [];

  void setCourses(apiRes) {
    courses = apiRes;
    notifyListeners();
  }
}
