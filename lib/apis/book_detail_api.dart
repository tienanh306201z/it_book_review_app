import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getBookDetail(String id) async {
  var response =
      await http.get(Uri.parse('https://api.itbook.store/1.0/books/$id'));
  final data = json.decode(response.body) as Map<String, dynamic>;
  print(data);
  return data;
}
