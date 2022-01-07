import 'package:flutter/material.dart';
import 'package:online_book_review_app/models/new_book.dart';
import 'package:online_book_review_app/providers/saved_books_provider.dart';
import 'package:online_book_review_app/screens/book_detail_screen.dart';
import 'package:online_book_review_app/utils/url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class BookCard extends StatefulWidget {
  NewBook newBook;

  BookCard({Key? key, required this.newBook}) : super(key: key);

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    final savedBooksProvider = Provider.of<SavedBooks>(context);
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(BookDetailScreen.tag, arguments: widget.newBook.isbn13),
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.newBook.isbn13,
              child: CachedNetworkImage(
                imageUrl: widget.newBook.image,
                height: size.height * 0.15,
                fit: BoxFit.fitWidth,
                placeholder: (_, url) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: size.width * 0.1,
                  height: size.height * 0.15,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (_, error, url) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: size.width * 0.1,
                  height: size.height * 0.15,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    widget.newBook.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    widget.newBook.subtitle == ''
                        ? 'An IT book from IT Book Store'
                        : widget.newBook.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
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
                    widget.newBook.price == '\$0.00'
                        ? 'Free'
                        : widget.newBook.price,
                    style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
