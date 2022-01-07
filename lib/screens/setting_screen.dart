import 'package:flutter/material.dart';
import 'package:online_book_review_app/providers/saved_books_provider.dart';
import 'package:online_book_review_app/screens/sign_in_screen.dart';
import 'package:online_book_review_app/services/authentication_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  static const tag = '/setting';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  bool _isLoading = false;
  final EmailAndPassWordAuth _emailAndPassWordAuth = EmailAndPassWordAuth();

  @override
  Widget build(BuildContext context) {
    final savedBooksProvider = Provider.of<SavedBooks>(context, listen: false);
    return SafeArea(
        child: LoaderOverlay(
          useDefaultLoading: _isLoading,
          child: Column(
      children: [
          const SizedBox(
            height: 30,
          ),
          Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Text(
                'Cài đặt',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.left,
              )),
          ElevatedButton(
            onPressed: () async {
              await launch(
                  'https://www.facebook.com/ceilingprogressproductions2001/');
            },
            child: Text('Trang facebook cá nhân của tôi'),
            style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width - 10, 20),
                primary: Colors.lightBlueAccent.shade700),
          ),
          ElevatedButton(
            onPressed: () async {
              await launch('https://github.com/tienanh306201z');
            },
            child: Text('Kênh github của tôi'),
            style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width - 10, 20),
                primary: Colors.black),
          ),
          ElevatedButton(
            onPressed: () async {
              if(mounted){
                setState(() {
                  _isLoading = true;
                });
              }
              context.loaderOverlay.show();
              await _emailAndPassWordAuth.logOut();

              if(mounted){
                setState(() {
                  _isLoading = false;
                });
              }
              context.loaderOverlay.hide();

              savedBooksProvider.resetList();

              Navigator.of(context).pushReplacementNamed(SignInScreen.tag);
            },
            child: Text('Đăng xuất'),
            style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width - 10, 20),
                primary: Colors.black54),
          ),
      ],
    ),
        ));
  }
}
