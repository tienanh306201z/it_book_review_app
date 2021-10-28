class NewBook {
  late String title;
  late String subtitle;
  late String isbn13;
  late String price;
  late String image;
  late String url;

  NewBook(
      {required this.title,
        required this.subtitle,
        required this.isbn13,
        required this.price,
        required this.image,
        required this.url});

  NewBook.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    isbn13 = json['isbn13'];
    price = json['price'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['isbn13'] = isbn13;
    data['price'] = price;
    data['image'] = image;
    data['url'] = url;
    return data;
  }
}