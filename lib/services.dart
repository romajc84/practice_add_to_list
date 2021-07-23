import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:practice_add_to_list/api.dart';

class RemoteServices {
  static var client = http.Client();
}

Future<Stock2> getQuotes() async {
  final response = await http.get(
    Uri.parse('${endpoint}markets/quotes?symbols=SQ,TSLA&greeks=false'),
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );
  final responseJson = jsonDecode(response.body);

  return Stock2.fromJson(responseJson);
}

class Stock2 {
  final double last;
  final double changePercentage;

  Stock2({required this.last, required this.changePercentage});

  factory Stock2.fromJson(Map<String, dynamic> json) {
    return Stock2(
      last: json['last'],
      changePercentage: json['change_percentage'],
    );
  }
}
