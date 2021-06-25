part of 'sign_in.dart';

FormData _$FormDataFromJson(Map<String, dynamic> json) {
  return FormData(
    employeeId: json['employeeId'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$FormDataToJson(FormData instance) => <String, dynamic>{
      'email': instance.employeeId,
      'password': instance.password,
    };
