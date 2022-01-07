import 'package:flutter/material.dart';
import 'package:online_book_review_app/apis/new_book_api.dart';
import 'package:online_book_review_app/screens/home_screen.dart';
import 'package:online_book_review_app/screens/sign_in_screen.dart';
import 'package:online_book_review_app/screens/tab_screens.dart';

class BeginningScreen extends StatefulWidget {
  const BeginningScreen({Key? key}) : super(key: key);

  @override
  State<BeginningScreen> createState() => _BeginningScreenState();
}

class _BeginningScreenState extends State<BeginningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Bitmap.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: RichText(
                text: TextSpan(
                  text: 'IT',
                  style: Theme.of(context).textTheme.headline3,
                  children: [
                    TextSpan(
                        text: ' Book Review',
                        style: Theme.of(context).textTheme.headline5),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(SignInScreen.tag);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 30,
                          color: Colors.black12)
                    ]),
                child: Text(
                  'Bắt đầu',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
