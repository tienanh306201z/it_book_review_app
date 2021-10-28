import 'package:flutter/material.dart';
import 'package:online_book_review_app/apis/book_detail_api.dart';
import 'package:online_book_review_app/screens/pdf_view_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'amazon_order_screen.dart';

class BookDetailScreen extends StatelessWidget {
  static const tag = '/book-detail';

  const BookDetailScreen({Key? key}) : super(key: key);

  Widget bookDetailWidget(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: RichText(
        text: TextSpan(
          text: title,
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: detail,
              style: const TextStyle(color: Colors.black45),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: getBookDetail(id),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              final _bookData = snapshot.data as Map<String, dynamic>;
              List<Map<String, String>> _bookChapters = [];
              if (_bookData['pdf'] != null)
                _bookData['pdf'].forEach((key, value) {
                  _bookChapters.add({
                    'chapter': key,
                    'link': value,
                  });
                });
              return Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg.png'),
                      fit: BoxFit.fill),
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.arrow_back_ios_outlined),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_border),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _bookData['title'],
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        _bookData['subtitle'],
                                        style: const TextStyle(
                                          color: Colors.black38,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () => _bookData['price'] ==
                                                    '\$0.00'
                                                ? Navigator.of(context)
                                                    .pushNamed(
                                                        PDFViewerScreen.tag,
                                                        arguments:
                                                            _bookChapters[0]
                                                                ['link'])
                                                : Navigator.of(context).pushNamed(
                                                    AmazonOrderScreen.tag,
                                                    arguments:
                                                        'https://www.amazon.com/dp/${_bookData["isbn10"]}/'),
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        offset: Offset(0, 15),
                                                        blurRadius: 30,
                                                        color: Colors.black12)
                                                  ]),
                                              child: Text(
                                                _bookData['price'] == '\$0.00'
                                                    ? 'Đọc sách'
                                                    : 'Mua sách',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                _bookData['price'] == '\$0.00'
                                                    ? 'Free'
                                                    : _bookData['price'],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Hero(
                                  tag: _bookData['isbn13'],
                                  child: CachedNetworkImage(
                                    imageUrl: _bookData['image'],
                                    height: 170,
                                    fit: BoxFit.fitWidth,
                                    placeholder: (_, url) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      width: 100,
                                      height: 170,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    errorWidget: (_, error, url) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      width: 100,
                                      height: 170,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                'Chi tiết',
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Divider(
                              thickness: 2,
                              height: 20,
                            ),
                            bookDetailWidget('Tên sách: ', _bookData['title']),
                            bookDetailWidget('Giá bán: ', _bookData['price']),
                            bookDetailWidget('Tác giả: ', _bookData['authors']),
                            bookDetailWidget(
                                'Nhà xuất bản: ', _bookData['publisher']),
                            bookDetailWidget(
                                'Năm xuất bản: ', _bookData['year']),
                            if (_bookData['language'] != null)
                              bookDetailWidget(
                                  'Ngôn ngữ: ', _bookData['language']),
                            bookDetailWidget('Nội dung: ', _bookData['desc']),
                            bookDetailWidget('Số trang: ', _bookData['pages']),
                            if (_bookData['pdf'] != null)
                              ..._bookChapters
                                  .map(
                                    (e) => InkWell(
                                      onTap: () => Navigator.of(context)
                                          .pushNamed(PDFViewerScreen.tag,
                                              arguments: e['link']),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: const [
                                              BoxShadow(
                                                  offset: Offset(0, 15),
                                                  blurRadius: 30,
                                                  color: Colors.black12)
                                            ]),
                                        child: ListTile(
                                          title: Text(
                                            e['chapter'] as String,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          trailing:
                                              const Icon(Icons.arrow_right),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
