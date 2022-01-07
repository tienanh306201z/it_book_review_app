import 'package:flutter/material.dart';
import 'package:online_book_review_app/providers/saved_books_provider.dart';
import 'package:online_book_review_app/widgets/book_card.dart';
import 'package:provider/provider.dart';

class SaveScreen extends StatefulWidget {
  static const tag = '/save';

  const SaveScreen({Key? key}) : super(key: key);

  @override
  _SaveScreenState createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  @override
  Widget build(BuildContext context) {
    final savedBooksProvider = Provider.of<SavedBooks>(context);
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              width: double.infinity,
              child: RichText(
                text: TextSpan(
                    text: 'Bài viết bạn ',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                        text: 'đã lưu!',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.w700),
                      )
                    ]),
              ),
            ),
            if (savedBooksProvider.savedBooks.isEmpty)
              Text('Chưa có sách nào được lưu!'),
            if (savedBooksProvider.savedBooks.isNotEmpty)
              ...savedBooksProvider.savedBooks.map((e) => BookCard(newBook: e)),
          ],
        ),
      ),
    );
  }
}
