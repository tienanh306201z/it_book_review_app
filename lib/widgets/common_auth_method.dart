import 'package:flutter/material.dart';
import 'package:online_book_review_app/screens/sign_in_screen.dart';
import 'package:online_book_review_app/screens/sign_up_screen.dart';

Widget authTextFormField({required String hintText, required String? Function(String? inputVal) validator, required TextEditingController textEditingController}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: TextFormField(
      validator: validator,
      controller: textEditingController,
      obscureText: hintText.toLowerCase() == 'email' ? false : true,
      enableSuggestions: hintText.toLowerCase() == 'email' ? true : false,
      autocorrect: hintText.toLowerCase() == 'email' ? true : false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide:
            BorderSide(width: 1, color: Colors.grey.withOpacity(0.3))),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(width: 1, color: Colors.grey.withOpacity(0.3))),
      ),
    ),
  );
}

Widget switchToAnotherAuthScreen(
    {required BuildContext context,
      required String buttonNameFirst,
      required String buttonNameLast}) {
  return ElevatedButton(
    onPressed: () {
      if(buttonNameLast.trim() == 'Đăng ký'){
        Navigator.of(context).pushReplacementNamed(SignUpScreen.tag);
      }
      else Navigator.of(context).pushReplacementNamed(SignInScreen.tag);
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          buttonNameFirst,
          style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 13,
              letterSpacing: 1,
              decoration: TextDecoration.underline),
        ),
        Text(
          buttonNameLast,
          style: const TextStyle(
              color: Colors.lightBlueAccent, fontSize: 13, letterSpacing: 1.0),
        ),
      ],
    ),
    style: ElevatedButton.styleFrom(elevation: 0, primary: Colors.transparent),
  );
}