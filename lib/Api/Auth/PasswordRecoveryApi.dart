import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<int?> sendOTPRequest(String email) async {
  final url = Uri.parse('https://finace-management-api-typescript.onrender.com/api/v1/auth/request-otp');
  final body = json.encode({'email': email});

  try {
    final response = await http.post(
      url,
      headers: {

        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: body,
    );
    return response.statusCode;
  } catch (e) {
    if (e is SocketException) {
      print('Network error: $e');
      return null; // Or handle network errors differently
    } else {
      print('Unexpected error: $e');
      return null; // Or handle other unexpected errors
    }
  }
}