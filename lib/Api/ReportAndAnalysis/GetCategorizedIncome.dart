import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchCategorizedIncome(String bearerToken) async {
  const url = 'https://finace-management-api-typescript.onrender.com/api/v1/transactions/income/categorize';

  final headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer $bearerToken',
  };

  try {
    final response = await http.get(Uri.parse(url), headers: headers);

    // Parse the response
    final responseBody = json.decode(response.body);

    // Return the status code and either the data or an error message
    return {
      'status_code': response.statusCode,
      'data': response.statusCode == 200
          ? responseBody['data'] // Return 'data' on success
          : {'error': responseBody['message'] ?? 'An unknown error occurred'}, // Return error message on failure
    };
  } catch (e) {
    // Handle any unexpected errors gracefully
    return {
      'status_code': 500,
      'data': {'error': 'Failed to fetch data: $e'},
    };
  }
}


