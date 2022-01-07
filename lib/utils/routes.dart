import 'package:flutter/cupertino.dart';
import 'package:online_book_review_app/providers/saved_books_provider.dart';
import 'package:online_book_review_app/screens/amazon_order_screen.dart';
import 'package:online_book_review_app/screens/book_detail_screen.dart';
import 'package:online_book_review_app/screens/home_screen.dart';
import 'package:online_book_review_app/screens/pdf_view_screen.dart';
import 'package:online_book_review_app/screens/save_screen.dart';
import 'package:online_book_review_app/screens/search_screen.dart';
import 'package:online_book_review_app/screens/setting_screen.dart';
import 'package:online_book_review_app/screens/sign_in_screen.dart';
import 'package:online_book_review_app/screens/sign_up_screen.dart';
import 'package:online_book_review_app/screens/tab_screens.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.tag: (ctx) => HomeScreen(),
  BookDetailScreen.tag: (ctx) => BookDetailScreen(),
  PDFViewerScreen.tag: (ctx) => PDFViewerScreen(),
  SearchScreen.tag: (ctx) => SearchScreen(),
  TabsScreen.tag: (ctx) => TabsScreen(),
  AmazonOrderScreen.tag: (ctx) => AmazonOrderScreen(),
  SignInScreen.tag: (ctx) => SignInScreen(),
  SignUpScreen.tag: (ctx) => SignUpScreen(),
  SaveScreen.tag: (ctx) => SaveScreen(),
  SettingScreen.tag: (ctx) => SettingScreen(),
};
