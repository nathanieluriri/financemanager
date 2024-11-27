
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchGoalStats(String bearerToken) async {
  final url = Uri.parse('https://finace-management-api-typescript.onrender.com/api/v1/goals/stats');
  final headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer $bearerToken',
  };

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // Parse the JSON response
      final jsonResponse = json.decode(response.body);
      final stats = jsonResponse['data'];
      return {
        'status_code': response.statusCode,
        'goalsStats': '${stats['completedGoals']}/${stats['totalGoals']}',
      };
    } else {
      // Handle non-200 responses
      return {
        'status_code': response.statusCode,
        'goalsStats': 'Error fetching data',
      };
    }
  } catch (e) {
    // Handle network or JSON parsing errors
    print('Error: $e');
    return {
      'status_code': -1,
      'goalsStats': 'Error occurred',
    };
  }
}
