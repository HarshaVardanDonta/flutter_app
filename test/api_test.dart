import 'dart:convert';
import 'package:flutter_app/network.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

// Mock class for the HTTP client
class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('getCoursesApi', () {
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
    });

    test('returns a list of courses when the API call is successful', () async {
      // Arrange: Mock the response from the API
      final mockResponseData = [
        {"id": 1, "name": "Course 1", "duration": "10 weeks"},
        {"id": 2, "name": "Course 2", "duration": "8 weeks"}
      ];
      when(mockHttpClient.get(Uri.parse("http://10.0.2.2:3001/courses")))
          .thenAnswer(
              (_) async => http.Response(jsonEncode(mockResponseData), 200));

      // Act
      var result = await getCoursesApi();

      // Assert
      expect(result.length, 2);
      expect(result[0].name, "Course 1");
      expect(result[1].duration, "8 weeks");
    });

    test('throws an exception when the API call fails', () async {
      // Arrange: Mock a failed response
      when(mockHttpClient.get(Uri.parse("http://10.0.2.2:3001/courses")))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act & Assert
      expect(() => getCoursesApi(), throwsException);
    });
  });
}
