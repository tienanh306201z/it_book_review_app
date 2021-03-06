import 'package:flutter/material.dart';
import 'package:loader_overlay/src/overlay_controller_widget_extension.dart';
import 'package:online_book_review_app/screens/sign_in_screen.dart';
import 'package:online_book_review_app/services/authentication_service.dart';
import 'package:online_book_review_app/utils/enum_generation.dart';
import 'package:online_book_review_app/utils/reg_exp.dart';
import 'package:online_book_review_app/widgets/common_auth_method.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SignUpScreen extends StatefulWidget {
  static const tag = '/sign-up';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();


  final EmailAndPassWordAuth _emailAndPassWordAuth = EmailAndPassWordAuth();

  bool _isLoading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Bitmap.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: LoaderOverlay(
          useDefaultLoading: _isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Column(
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
                Expanded(
                  child: Form(
                    key: _signUpKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        authTextFormField(
                            hintText: 'Email',
                            validator: (inputVal) {
                              if (!emailRegex.hasMatch(inputVal.toString())) {
                                return 'B???n ???? nh???p sai email!';
                              }
                              return null;
                            },
                            textEditingController: _email),
                        authTextFormField(
                            hintText: 'M???t kh???u',
                            validator: (inputVal) {
                              if (inputVal!.length < 6) {
                                return 'M???t kh???u ph???i c?? ??t nh???t 6 k?? t???!';
                              }
                              if (_password.text != _confirmPassword.text) {
                                return 'M???t kh???u v?? Nh???p l???i m???t kh???u kh??ng tr??ng kh???p!';
                              }
                              return null;
                            },
                            textEditingController: _password),
                        authTextFormField(
                            hintText: 'Nh???p l???i m???t kh???u',
                            validator: (inputVal) {
                              if (inputVal!.length < 6) {
                                return 'M???t kh???u ph???i c?? ??t nh???t 6 k?? t???!';
                              }
                              if (_password.text != _confirmPassword.text) {
                                return 'M???t kh???u v?? Nh???p l???i m???t kh???u kh??ng tr??ng kh???p';
                              }
                              return null;
                            },
                            textEditingController: _confirmPassword),
                        signUpAuthButton(
                            context: context, buttonName: 'T???o t??i kho???n'),
                        switchToAnotherAuthScreen(
                            context: context,
                            buttonNameFirst: '???? c?? t??i kho???n?',
                            buttonNameLast: ' ????ng nh???p'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpAuthButton(
      {required BuildContext context, required String buttonName}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: ElevatedButton(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          if (_signUpKey.currentState!.validate()) {
            print('Validated');

            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }

            context.loaderOverlay.show();

            final EmailSignUpResults response =
            await _emailAndPassWordAuth.signUpAuth(
                email: _email.value.text.trim(), password: _password.value.text);

            if (response == EmailSignUpResults.SignUpCompleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('????ng k?? th??nh c??ng')));
              Navigator.of(context).pushReplacementNamed(SignInScreen.tag);
            } else if (response == EmailSignUpResults.SignUpNotCompleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('????ng k?? th???t b???i')));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('T??i kho???n ???? t???n t???i')));
            }
          } else {
            print('Errors occurred');
          }

          context.loaderOverlay.hide();

          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width - 60, 30),
          primary: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        child: Text(
          buttonName,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
