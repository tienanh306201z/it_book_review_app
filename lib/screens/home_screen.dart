import 'package:flutter/material.dart';
import 'package:online_book_review_app/apis/new_book_api.dart';
import 'package:online_book_review_app/apis/search_book_api.dart';
import 'package:online_book_review_app/models/new_book.dart';
import 'package:online_book_review_app/providers/saved_books_provider.dart';
import 'package:online_book_review_app/utils/url.dart';
import 'package:online_book_review_app/widgets/book_card.dart';
import 'package:online_book_review_app/widgets/new_reading_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const tag = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getNewBooks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<NewBook> _newBooks = snapshot.data as List<NewBook>;
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        foregroundImage: NetworkImage(USER_DEFAULT_ICON),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text.rich(
                        TextSpan(
                            text: 'Xin chào ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis),
                            children: [
                              TextSpan(
                                text: _firebaseAuth.currentUser!.email
                                            .toString()
                                            .length >
                                        30
                                    ? "${_firebaseAuth.currentUser!.email.toString().substring(0, 30)}..."
                                    : _firebaseAuth.currentUser!.email
                                        .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              TextSpan(text: '!'),
                            ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                        text: 'Bạn nên đọc gì ',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: 'hôm nay?',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.w700),
                          )
                        ]),
                  ),
                ),
                FutureBuilder(
                    future: getSearchBook('am', 1),
                    builder: (_, _snapshot) {
                      if (_snapshot.hasData) {
                        List<NewBook> _books = _snapshot.data as List<NewBook>;
                        return SizedBox(
                          height: 260,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (_, index) =>
                                NewsReadingCard(newBook: _books[index]),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                        text: 'Sách ',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: 'mới!',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.w700),
                          )
                        ]),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _newBooks.length,
                    itemBuilder: (_, index) =>
                        BookCard(newBook: _newBooks[index])),
                SizedBox(
                  height: size.height * 0.12,
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
