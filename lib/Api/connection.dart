import 'dart:convert'; // For decoding JSON response
import 'package:http/http.dart' as http; // For making HTTP requests

Future<bool> connectionStatus() async {
  final url = Uri.parse('https://finace-management-api-typescript.onrender.com/api/v1/true');

  try {
    // Sending GET request
    final response = await http.get(url);

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Decode the JSON response
      final responseData = json.decode(response.body);

      // Return the "message" from the response
      return responseData['message'];
    } else {
      // If the request was not successful, throw an error
      throw Exception('Failed to load message');
    }
  } catch (e) {
    // Handle any errors
    return false;
  }
}

