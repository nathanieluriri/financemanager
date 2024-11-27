import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> createIncomeTransaction({
  required String bearerToken,
  required String name,
  required int amount,
  required String categoryId,
}) async {
  final url = Uri.parse(
      'https://finace-management-api-typescript.onrender.com/api/v1/transactions/income');
  final headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer $bearerToken',
    'Content-Type': 'application/json',
  };
  final body = json.encode({
    'name': name,
    'amount': amount,
    'category': categoryId,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      // Parse the successful response
      final jsonResponse = json.decode(response.body);
      Fluttertoast.showToast(
          msg: "Transaction Successful",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14.0
      );
      return {
        'status_code': response.statusCode,
        'message': jsonResponse['message'],
        'data': jsonResponse['data'],
      };
    } else {
      Fluttertoast.showToast(
          msg: "Transaction Unsuccessful  ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0
      );
      // Handle errors
      return {
        'status_code': response.statusCode,
        'message': 'Failed to create income transaction',
        'error': response.body,
      };
    }
  } catch (e) {
    // Handle exceptions
    Fluttertoast.showToast(
        msg: "Network Error ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepOrange,
        textColor: Colors.white,
        fontSize: 14.0
    );
    print('Error: $e');
    return {
      'status_code': -1,
      'message': 'An error occurred',
      'error': e.toString(),
    };
  }
}
