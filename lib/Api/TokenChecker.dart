import 'dart:io';

import 'package:http/http.dart' as http;

Future<int?> getStatusCodeWithBearerToken( String bearerToken) async {
  try {
    final response = await http.get(
      Uri.parse("https://finace-management-api-typescript.onrender.com/api/v1/transactions"),
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Accept': 'application/json',
      },
    );
    return response.statusCode;
  } catch (e) {
    if (e is SocketException) {

      // Handle network errors, e.g., retry the request or display an error message
      return -1;
    } else {

      // Handle other unexpected errors, e.g., log the error or display a generic error message
      return -1;
    }
  }
}