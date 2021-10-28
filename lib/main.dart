import 'package:flutter/material.dart';
import 'package:online_book_review_app/screens/beginning_screen.dart';
import 'package:online_book_review_app/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online IT Book Review App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
          displayColor: Colors.black,
        )
      ),
      home: const BeginningScreen(),
      routes: routes,
    );
  }
}
