import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

Future<bool> registerUser({
  required String firstName,
  required String secondName,
  required String email,
  required String password,
  required Box userdb,
}) async {
  const String url = 'https://finace-management-api-typescript.onrender.com/api/v1/auth/register';
  final Map<String, String> headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
  };
  final Map<String, String> body = {
    'first_name': firstName,
    'second_name': secondName,
    'email': email,
    'password': password,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    // Parse the response
    final Map<String, dynamic> responseData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      print('Registration successful:');
      print('Status Code: ${responseData['status_code']}');
      print('Message: ${responseData['message']}');
      print('User ID: ${responseData['data']['user']['id']}');
      print('First Name: ${responseData['data']['user']['first_name']}');
      print('Second Name: ${responseData['data']['user']['second_name']}');
      print('Email: ${responseData['data']['user']['email']}');
      print('Token: ${responseData['data']['token']}');


      userdb.put("User ID", "${responseData['data']['user']['id']}");
      userdb.put("First Name", "${responseData['data']['user']['first_name']}");
      userdb.put("Second Name", "${responseData['data']['user']['second_name']}");
      userdb.put("Email", "${responseData['data']['user']['email']}");
      userdb.put("Token", "${responseData['data']['token']}");
      userdb.put("Balance", "${responseData['data']['balance']}");
      Fluttertoast.showToast(
          msg: "Login Succesful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 14.0
      );
      return true;
    } else if (response.statusCode == 403) {
      print('Error: ${responseData['message']}');
      Fluttertoast.showToast(
          msg: " Login failed: - ${responseData['message']}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 12.0
      );
      return false;
    } else {
      print('Registration failed: ${response.statusCode} - ${response.body}');
      Fluttertoast.showToast(
          msg: " Login failed: - ${responseData['message']}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 12.0
      );
      return false;
    }
  } catch (e) {
    print('Error during registration: $e');
    Fluttertoast.showToast(
        msg: "No Network",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 12.0
    );
    return false;
  }
}
