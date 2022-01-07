import 'package:flutter/material.dart';
import 'package:online_book_review_app/providers/saved_books_provider.dart';
import 'package:online_book_review_app/screens/beginning_screen.dart';
import 'package:online_book_review_app/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SavedBooks>(
      create: (_) => SavedBooks(),
      child: MaterialApp(
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
      ),
    );
  }
}
