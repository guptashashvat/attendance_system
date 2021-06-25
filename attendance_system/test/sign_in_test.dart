import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:attendance_system/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_in_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {}
