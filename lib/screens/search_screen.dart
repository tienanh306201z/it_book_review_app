import 'package:flutter/material.dart';
import 'package:online_book_review_app/apis/search_book_api.dart';
import 'package:online_book_review_app/models/new_book.dart';
import 'package:online_book_review_app/widgets/book_card.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SearchScreen extends StatefulWidget {
  static const tag = '/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String currentVal = '';
  final _textController = TextEditingController();

  PagingController<int, NewBook> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 0);

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await getSearchBook(_textController.value.text, pageKey);
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _pagingController.dispose();
    super.dispose();
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
                if (_textController.text != currentVal ||
                    _textController.value == null) {
                  _pagingController.refresh();
                  currentVal = _textController.text;
                }
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
          PagedListView<int, NewBook>(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            pagingController: _pagingController,
            scrollController: _scrollController,
            builderDelegate: PagedChildBuilderDelegate<NewBook>(
              newPageProgressIndicatorBuilder: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
              itemBuilder: (context, item, index) =>
                  AnimationConfiguration.staggeredList(
                duration: const Duration(milliseconds: 500),
                position: index,
                child: ScaleAnimation(
                  child: FadeInAnimation(child: BookCard(newBook: item)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.15,
          )
        ],
      ),
    );
  }
}
