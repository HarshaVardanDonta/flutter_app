import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Course>> getCoursesApi() async {
  var res = await http.get(Uri.parse("http://10.0.2.2:3001/courses"));

  if (res.statusCode == 200) {
    var data = jsonDecode(res.body) as List;
    List<Course> courses =
        data.map((course) => Course.fromJson(course)).toList();
    return courses;
  } else {
    throw Exception("Failed to load courses. Status code: ${res.statusCode}");
  }
}

submitCources(String name, String email, List<int> selectedCources) async {
  var headers = {'Content-Type': 'application/json'};
  var request =
      http.Request('POST', Uri.parse('https://api.restful-api.dev/objects'));
  request.body = json.encode({
    "data": {"name": name, "email": email, "selectedCources": selectedCources}
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

class Course {
  final int id;
  final String name;
  final String duration;

  Course(this.id, this.name, this.duration);

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(json['id'], json['name'], json['duration']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'duration': duration};
  }
}
