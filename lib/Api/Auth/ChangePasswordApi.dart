import 'package:http/http.dart' as http;
import 'dart:convert';

Future<int> verifyOtpAndPassword(String email, String otp, String newPassword) async {
  final url = Uri.parse('https://finace-management-api-typescript.onrender.com/api/v1/auth/verify-otp-and-change-password');
  final body = {'email': email, 'otp': otp, 'new_password': newPassword};

  final headers = {
    'accept': 'application/json',

    'Content-Type': 'application/json',
  };

  try {
    final response = await http.post(url, body: jsonEncode(body), headers: headers);
    return response.statusCode;
  } catch (e) {
    // Handle specific exceptions here (e.g., network errors, 401 unauthorized)
    print('Error: $e');
    return 500; // Or throw an appropriate exception based on the error
  }
}