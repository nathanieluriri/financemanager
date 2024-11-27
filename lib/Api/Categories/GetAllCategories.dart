import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchCategories(String bearerToken) async {
  final url = Uri.parse(
      'https://finace-management-api-typescript.onrender.com/api/v1/categories');
  final headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer $bearerToken'
  };

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final categories = jsonResponse['data'];
      return {
        'status_code': response.statusCode,
        'categories': categories,
      };
    } else {
      // Return the status code and an empty list on failure
      return {
        'status_code': response.statusCode,
        'categories': [],
      };
    }
  } catch (e) {
    // Return a status code of -1 and an empty list on exception
    return {
      'status_code': -1,
      'categories': [],
    };
  }
}


void main() async {
  String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3NDQ3YTViYWU5NzI5N2U0NjZmMjQ1YyIsImVtYWlsIjoic3RyaW5nIiwiaWF0IjoxNzMyNTQxNjg5LCJleHAiOjE3MzI1NDUyODl9.Jt6P3urITF6aY5N-prrCKwDeEsdw0yrr2-D8Zi7Xp3s';
  final result = await fetchCategories(token);

  print('Status Code: ${result['status_code']}');
  print('Categories:');
  for (var category in result['categories']) {
    print('Category Name: ${category['category_name']}');
    print('Priority Type: ${category['priority_type']}');
    print('Category Type: ${category['category_type']}');
    print('---');
  }
}
