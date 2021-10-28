import 'package:flutter/material.dart';
import 'package:online_book_review_app/apis/search_book_api.dart';
import 'package:online_book_review_app/models/new_book.dart';
import 'package:online_book_review_app/widgets/book_card.dart';
import 'package:online_book_review_app/widgets/bottom_nav_bar.dart';

class SearchScreen extends StatefulWidget {
  static const tag = '/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _recentPage = 1;
  int _totalPage = 1;
  final _textController = TextEditingController();

  @override
  void initState() {
    getAPI();
    super.initState();
  }
  void getAPI() async {
    final data = await getSearchBook(_textController.value.text, _recentPage);
    print(data);
  }
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void setMaxPages(int pages){
      _totalPage = pages;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.06,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xFFF1DAD8).withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff005c7e).withOpacity(0.05),
                      offset: const Offset(0, 10),
                      blurRadius: 5)
                ]),
            child: TextField(
              controller: _textController,
              onSubmitted: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.search,
                  color: Colors.deepOrangeAccent.withGreen(150),
                ),
                hintText: 'Nhập vào tên sách',
              ),
            ),
          ),
          FutureBuilder(
              future: getSearchBook(_textController.value.text, _recentPage),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<NewBook> _books = snapshot.data as List<NewBook>;
                  return Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _books.length,
                          itemBuilder: (_, index) =>
                              BookCard(newBook: _books[index])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if(_recentPage > 1) InkWell(
                              onTap: () => setState(() {
                                _recentPage -= 1;
                              }),
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_back_ios),
                                    Text(
                                      'Trang trước',
                                      style: Theme.of(context).textTheme.headline6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    'Trang kế',
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
          SizedBox(
            height: size.height * 0.15,
          )
        ],
      ),
    );
  }
}
