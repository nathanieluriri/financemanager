import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchTransactions(String token) async {
  const url = 'https://finace-management-api-typescript.onrender.com/api/v1/transactions';

  try {
    // Perform the GET request
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // Check if the response status is success
    if (response.statusCode == 200) {
      // Parse the JSON response and return it
      return json.decode(response.body);
    } else {
      // Return error details if status code is not 200
      return {
        'status_code': response.statusCode,
        'message': 'Failed to fetch transactions: ${response.reasonPhrase}',
      };
    }
  } catch (e) {
    // Handle exceptions such as network issues
    return {
      'status_code': 500,
      'message': 'An error occurred: $e',
    };
  }
}
