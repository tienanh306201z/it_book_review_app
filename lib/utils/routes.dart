import 'package:flutter/cupertino.dart';
import 'package:online_book_review_app/screens/amazon_order_screen.dart';
import 'package:online_book_review_app/screens/book_detail_screen.dart';
import 'package:online_book_review_app/screens/home_screen.dart';
import 'package:online_book_review_app/screens/pdf_view_screen.dart';
import 'package:online_book_review_app/screens/search_screen.dart';
import 'package:online_book_review_app/screens/tab_screens.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.tag: (ctx) => HomeScreen(),
  BookDetailScreen.tag: (ctx) => BookDetailScreen(),
  PDFViewerScreen.tag: (ctx) => PDFViewerScreen(),
  SearchScreen.tag: (ctx) => SearchScreen(),
  TabsScreen.tag: (ctx) => TabsScreen(),
  AmazonOrderScreen.tag: (ctx) => AmazonOrderScreen(),
};
