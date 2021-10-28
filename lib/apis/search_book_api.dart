import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_book_review_app/models/new_book.dart';

Future<List<NewBook>> getSearchBook(String query, int page) async {
  if (query.isEmpty || query == null || query.length < 2) query = 'an';
  print(query);
  final response = await http.get(
    Uri.parse('https://api.itbook.store/1.0/search/$query/$page'),
  );
  List<NewBook> _searchBooks = [];
  if (response.statusCode == 200) {
    final jsonFile = json.decode(response.body);
    final data = jsonFile['books'] as List<dynamic>;
    print(response.body);
    _searchBooks = data.map((e) => NewBook.fromJson(e)).toList();
  } else {
    print(response.reasonPhrase);
  }
  return _searchBooks;
}
