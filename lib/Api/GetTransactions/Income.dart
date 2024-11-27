import 'dart:convert'; // For decoding JSON
import 'package:http/http.dart' as http; // For making HTTP requests

Future<Map<String, dynamic>> fetchIncome(String token) async {
  final url = Uri.parse('https://finace-management-api-typescript.onrender.com/api/v1/transactions/income/total');

  try {
    // Make GET request with Authorization header
    final response = await http.get(
      url,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // Check the status code and decode the response
    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Return the response data

      return {
        'success': true,
        'message': responseData['message'],
        'balance': responseData['data']['total_income'],
      };
    } else {
      // Handle non-200 status codes
      final Map<String, dynamic> responseData = json.decode(response.body);
      return {

        'success': false,
        'message': 'Error: ${response.statusCode} - $responseData',

      };
    }
  } catch (e) {
    // Handle exceptions
    return {
      'success': false,
      'message': 'Error: $e',
    };
  }
}
