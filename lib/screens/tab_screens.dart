import 'package:flutter/material.dart';
import 'package:online_book_review_app/providers/saved_books_provider.dart';
import 'package:online_book_review_app/screens/home_screen.dart';
import 'package:online_book_review_app/screens/save_screen.dart';
import 'package:online_book_review_app/screens/search_screen.dart';
import 'package:online_book_review_app/screens/setting_screen.dart';
import 'package:online_book_review_app/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  static const tag = '/tabs';

  TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _currentIndex = 0;
  bool _isFullyLoaded = false;

  didChangeDependencies(){
    if(!_isFullyLoaded)
      getSavedBooks();
    setState(() {
      _isFullyLoaded = true;
    });
    super.didChangeDependencies();
  }

  Future<void> getSavedBooks() async {
    await Provider.of<SavedBooks>(context).getSavedBooks();
  }

  List<Map<String, dynamic>> _screens = [
    {
      'screen': HomeScreen(),
      'index': 0,
    },
    {
      'screen': SearchScreen(),
      'index': 1,
    },
    {
      'screen': SaveScreen(),
      'index': 2,
    },
    {
      'screen': SettingScreen(),
      'index': 3,
    }
  ];

  void _setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/main_page_bg.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              _screens.firstWhere(
                  (element) => element['index'] == _currentIndex)['screen'],
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BottomNavBar(setIndex: _setIndex)),
            ],
          ),
        ),
      ),
    );
  }
}
