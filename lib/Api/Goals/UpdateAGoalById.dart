import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> updateGoalAccumulatedAmount({
  required String goalId,
  required String bearerToken,
  required int accumulatedAmount,
}) async {
  final url = Uri.parse(
      'https://finace-management-api-typescript.onrender.com/api/v1/goals/$goalId');
  final headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer $bearerToken',
    'Content-Type': 'application/json',
  };
  final body = json.encode({
    'accumulated_amount': accumulatedAmount,
  });

  try {
    final response = await http.patch(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Parse the successful response
      final jsonResponse = json.decode(response.body);
      return {
        'status_code': response.statusCode,
        'message': jsonResponse['message'],
      };
    } else {
      // Handle non-201 responses
      print(response.body);
      return {
        'status_code': response.statusCode,
        'message': 'Failed to update goal',
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
