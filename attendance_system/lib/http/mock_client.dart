import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {
  MockClient() {
    when(post('https://example.com/signin', body: anyNamed('body')))
        .thenAnswer((answering) {
      var body = answering.namedArguments[Symbol('body')];

      if (body != null && body is String) {
        var decodedJson = json.decode(body);

        if (decodedJson['employeeId'] == 'root' &&
            decodedJson['password'] == 'password') {
          return Future.value(http.Response('', 200));
        }
      }

      return Future.value(http.Response('', 401));
    });

    when(post('https://example.com/signout'))
        .thenAnswer((_) => Future.value(http.Response('', 401)));
  }
}
