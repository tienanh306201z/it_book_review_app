import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_book_review_app/models/new_book.dart';

Future<List<NewBook>> getNewBooks() async {
  var response = await http.get(Uri.parse('https://api.itbook.store/1.0/new'));
  List<NewBook> _newBooks = [];
  if (response.statusCode == 200) {
    final data = json.decode(response.body)['books'] as List<dynamic>;
    _newBooks = data.map((e) => NewBook.fromJson(e)).toList();
    print(json.decode(response.body)['books']);
  } else {
    print(response.reasonPhrase);
  }
  return _newBooks;
}
