import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import '../utilities/constants.dart';
import 'package:attendance_system/services/location.dart';

part '../screens/sign_in.g.dart';

const apiKey = 'b54ef4e248c57a88b5fa9023544ae2f8';

@JsonSerializable()
class FormData {
  String employeeId;
  String password;

  FormData({
    this.employeeId,
    this.password,
  });

  factory FormData.fromJson(Map<String, dynamic> json) =>
      _$FormDataFromJson(json);

  Map<String, dynamic> toJson() => _$FormDataToJson(this);
}

class SignIn extends StatefulWidget {
  SignIn({
    this.httpClient,
  });

  final http.Client httpClient;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FormData formData = FormData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Scrollbar(
        child: Form(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                ...[
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Your Employee Id',
                      labelText: 'Employee Id',
                    ),
                    onChanged: (value) {
                      formData.employeeId = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      formData.password = value;
                    },
                  ),
                  TextButton(
                    child: Text('Sign in'),
                    onPressed: () async {
                      String location = await Location().getCurrentLocation();

                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  location: location,
                                )),
                      );*/
                      Navigator.pushNamed(context, '/tabs');
                    },
                  ),
                ].expand(
                  (widget) => [
                    widget,
                    SizedBox(
                      height: 24,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
