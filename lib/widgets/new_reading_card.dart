import 'package:flutter/material.dart';
import 'package:online_book_review_app/models/new_book.dart';
import 'package:online_book_review_app/screens/book_detail_screen.dart';

class NewsReadingCard extends StatelessWidget {
  NewBook newBook;

  NewsReadingCard({Key? key, required this.newBook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(BookDetailScreen.tag, arguments: newBook.isbn13),
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
              tag: newBook.isbn13,
              child: Image.network(
                newBook.image,
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
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border),
                  ),
                  Text(
                    newBook.price == '\$0.00' ? 'Free' : newBook.price,
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
                      newBook.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      newBook.subtitle == ''
                          ? 'An IT book from IT Book Store'
                          : newBook.subtitle,
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
