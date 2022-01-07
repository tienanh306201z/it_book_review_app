import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_book_review_app/apis/book_detail_api.dart';
import 'package:online_book_review_app/models/new_book.dart';

class SavedBooks with ChangeNotifier {
  List<NewBook> _savedBooks = [];
  final _collectionName = 'saved_books';

  List<NewBook> get savedBooks {
    return [..._savedBooks];
  }

  Future<void> getSavedBooks() async {
    final email = FirebaseAuth.instance.currentUser!.email.toString();
    DocumentSnapshot<Map<String, dynamic>> results =
        await FirebaseFirestore.instance.doc('$_collectionName/${email}').get();
    if (!results.exists) {
      return;
    } else {
      results.data()!.forEach((key, value) {
        _savedBooks.add(NewBook.fromJson(value));
      });
    }
    notifyListeners();
  }

  Future<void> addBookToSaveList(NewBook newBook) async {
    final email = FirebaseAuth.instance.currentUser!.email.toString();
    DocumentSnapshot<Map<String, dynamic>> results =
        await FirebaseFirestore.instance.doc('$_collectionName/${email}').get();

    if (!results.exists) {
      _savedBooks.add(newBook);
      await FirebaseFirestore.instance
          .doc('$_collectionName/${email}')
          .set({"0": newBook.toJson()});
    } else if (results
        .data()!
        .values
        .any((element) => element['isbn13'] == newBook.isbn13)) {
      return;
    } else {
      _savedBooks.add(newBook);
      await FirebaseFirestore.instance.doc('$_collectionName/${email}').update(
          _savedBooks
              .asMap()
              .map((key, value) => MapEntry(key.toString(), value.toJson())));
    }
    notifyListeners();
  }

  Future<void> removeBookFromSaveList(NewBook newBook) async {
    final email = FirebaseAuth.instance.currentUser!.email.toString();
    DocumentSnapshot<Map<String, dynamic>> results =
        await FirebaseFirestore.instance.doc('$_collectionName/${email}').get();

    if (!results.exists) {
      return;
    } else if (!results
        .data()!
        .values
        .any((element) => element['isbn13'] == newBook.isbn13)) {
      return;
    } else {
      _savedBooks.removeWhere((element) => element.isbn13 == newBook.isbn13);
      await FirebaseFirestore.instance.doc('$_collectionName/${email}').update(
          _savedBooks
              .asMap()
              .map((key, value) => MapEntry(key.toString(), value.toJson())));
    }
    notifyListeners();
  }

  void resetList() {
    _savedBooks = [];
  }
}
