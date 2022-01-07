import 'package:flutter/material.dart';
import 'package:online_book_review_app/models/new_book.dart';
import 'package:online_book_review_app/providers/saved_books_provider.dart';
import 'package:online_book_review_app/screens/book_detail_screen.dart';
import 'package:provider/provider.dart';

class NewsReadingCard extends StatefulWidget {
  NewBook newBook;

  NewsReadingCard({Key? key, required this.newBook}) : super(key: key);

  @override
  State<NewsReadingCard> createState() => _NewsReadingCardState();
}

class _NewsReadingCardState extends State<NewsReadingCard> {
  @override
  Widget build(BuildContext context) {
    final savedBooksProvider = Provider.of<SavedBooks>(context);
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(BookDetailScreen.tag, arguments: widget.newBook.isbn13),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 245,
        width: 202,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                margin: const EdgeInsets.only(bottom: 25),
                height: 221,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff005c7e).withOpacity(0.05),
                        offset: const Offset(0, 10),
                        blurRadius: 5)
                  ],
                ),
              ),
            ),
            Hero(
              tag: widget.newBook.isbn13,
              child: Image.network(
                widget.newBook.image,
                fit: BoxFit.fitWidth,
                height: 130,
                width: 150,
              ),
            ),
            Positioned(
              top: 35,
              right: 10,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      if (savedBooksProvider.savedBooks
                          .any((element) => element.isbn13 == widget.newBook.isbn13))
                        savedBooksProvider
                            .removeBookFromSaveList(widget.newBook);
                      else
                        savedBooksProvider
                            .addBookToSaveList(widget.newBook);
                    },
                    icon: savedBooksProvider.savedBooks
                        .any((element) => element.isbn13 == widget.newBook.isbn13)
                        ? Icon(Icons.favorite_outlined)
                        : Icon(Icons.favorite_border),
                  ),
                  Text(
                    widget.newBook.price == '\$0.00' ? 'Free' : widget.newBook.price,
                    style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  )
                ],
              ),
            ),
            Positioned(
              top: 145,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 150,
                width: 202,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.newBook.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      widget.newBook.subtitle == ''
                          ? 'An IT book from IT Book Store'
                          : widget.newBook.subtitle,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 25,
              right: 0,
              child: Row(
                children: [
                  Container(
                    width: 101,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: const Text('Chi tiết'),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(29),
                          bottomRight: Radius.circular(29),
                        ),
                      ),
                      child: const Text(
                        'Đọc',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
