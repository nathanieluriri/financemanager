import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<int> createGoal({
  required String name,
  required int requiredAmount,
  required int accumulatedAmount,
  required String bearerToken,
}) async {
  final url = Uri.parse('https://finace-management-api-typescript.onrender.com/api/v1/goals');
  final headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer $bearerToken',
    'Content-Type': 'application/json',
  };
  final body = json.encode({
    'name': name,
    'required_amount': requiredAmount,
    'accumulated_amount': accumulatedAmount,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    Fluttertoast.showToast(
        msg: "${jsonDecode(response.body)['message']}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 12.0);
    return response.statusCode; // Return the status code directly
  } catch (e) {
    Fluttertoast.showToast(
        msg: "Network Issue",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
        fontSize: 12.0);
    print('Error: $e');
    return -1; // Return -1 in case of an error
  }
}
