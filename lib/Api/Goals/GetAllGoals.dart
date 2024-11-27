import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchGoals(String bearerToken) async {
  final url = Uri.parse('https://finace-management-api-typescript.onrender.com/api/v1/goals');
  final headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer $bearerToken',
  };

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // Parse the JSON response
      final jsonResponse = json.decode(response.body);
      return {
        'status_code': response.statusCode,
        'message': jsonResponse['message'],
        'data': jsonResponse['data'],
      };
    } else {
      // Handle non-200 responses
      return {
        'status_code': response.statusCode,
        'message': 'Failed to fetch goals',
        'error': response.body,
      };
    }
  } catch (e) {
    // Handle network or JSON parsing errors
    print('Error: $e');
    return {
      'status_code': -1,
      'message': 'An error occurred',
      'error': e.toString(),
    };
  }
}
