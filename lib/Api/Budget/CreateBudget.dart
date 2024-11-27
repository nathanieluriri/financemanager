import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> createBudget({
  required String budgetName,
  required int totalIncome,
  required String bearerToken,
}) async {
  final url = Uri.parse('https://finace-management-api-typescript.onrender.com/api/v1/budget');
  final headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer $bearerToken',
    'Content-Type': 'application/json',
  };
  final body = json.encode({
    'budget_name': budgetName,
    'total_income': totalIncome,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      Fluttertoast.showToast(
          msg: "  ${jsonResponse['message']}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 12.0
      );
      return {
        'status_code': response.statusCode,
        'message': jsonResponse['message'],
      };
    } else {
      Fluttertoast.showToast(
          msg: "Failed To Create Budget ",

          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
      return {
        'status_code': response.statusCode,
        'message': 'Failed to create budget',
      };
    }
  } catch (e) {
    Fluttertoast.showToast(
        msg: "Network Issue",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
        fontSize: 12.0);
    return {
      'status_code': -1,
      'message': 'An error occurred: $e',
    };
  }
}
