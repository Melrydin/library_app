import 'dart:convert';

import 'package:intl/intl.dart';

class Book {
  final int? id;
  final String category;
  final String title;
  final bool series;
  final int volume;
  final String author;
  final String publisher;
  final double price;
  final int isbn;
  final bool wishlist;
  final bool gift;
  final bool borrow;
  final DateTime? releaseDate;
  final DateTime? payDate;
  final DateTime? startDate;
  final DateTime? endDate;

  Book({
    this.id,
    required this.category,
    required this.title,
    required this.series,
    required this.volume,
    required this.author,
    required this.publisher,
    required this.price,
    required this.isbn,
    required this.wishlist,
    required this.gift,
    required this.borrow,
    required this.releaseDate,
    required this.payDate,
    required this.startDate,
    required this.endDate,
  });

  Book copyWith({
    int? id,
    String? category,
    String? title,
    bool? series,
    int? volume,
    String? author,
    String? publisher,
    double? price,
    int? isbn,
    bool? wishlist,
    bool? gift,
    bool? borrow,
    DateTime? releaseDate,
    DateTime? payDate,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Book(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      series: series ?? this.series,
      volume: volume ?? this.volume,
      author: author ?? this.author,
      publisher: publisher ?? this.publisher,
      price: price ?? this.price,
      isbn: isbn ?? this.isbn,
      wishlist: wishlist ?? this.wishlist,
      gift: gift ?? this.gift,
      borrow: borrow ?? this.borrow,
      releaseDate: releaseDate ?? this.releaseDate,
      payDate: payDate ?? this.payDate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'title': title,
      'series': series,
      'volume': volume,
      'author': author,
      'publisher': publisher,
      'price': price,
      'isbn': isbn,
      'wishlist': wishlist,
      'gift': gift,
      'borrow': borrow,
      'releaseDate':
          DateFormat('yyyy-MM-dd').format(releaseDate!) == '1970-01-01'
              ? null
              : DateFormat('yyyy-MM-dd').format(releaseDate!),
      'payDate': DateFormat('yyyy-MM-dd').format(payDate!) == '1970-01-01'
          ? null
          : DateFormat('yyyy-MM-dd').format(payDate!),
      'startDate': DateFormat('yyyy-MM-dd').format(startDate!) == '1970-01-01'
          ? null
          : DateFormat('yyyy-MM-dd').format(startDate!),
      'endDate': DateFormat('yyyy-MM-dd').format(endDate!) == '1970-01-01'
          ? null
          : DateFormat('yyyy-MM-dd').format(endDate!),
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] != null ? map['id'] as int : null,
      category: map['category'] != null ? map['category'] as String: 'category',
      title: map['title'] != null ? map['title'] as String: 'title',
      series: map['series'] != null ? map['series']as bool: false,
      volume: map['volume'] != null ? map['volume'] as int: 0,
      author: map['author'] != null ? map['author'] as String: 'author',
      publisher: map['publisher'] != null ? map['publisher'] as String: 'publisher',
      price: map['price'] != null ? map['price'] as double: 0.0,
      isbn: map['isbn'] != null ? map['isbn']as int: 0,
      wishlist: map['wishlist'] != null ? map['wishlist'] as bool: false,
      gift: map['gift'] != null ? map['gift'] as bool: false,
      borrow: map['borrow'] != null ? map['borrow'] as bool: false,
      releaseDate: map['releaseDate'] != null
          ? DateFormat('yyyy-MM-dd').parse(map['releaseDate'] as String)
          : null,
      payDate: map['payDate'] != null
          ? DateFormat('yyyy-MM-dd').parse(map['payDate'] as String)
          : null,
      startDate: map['startDate'] != null
          ? DateFormat('yyyy-MM-dd').parse(map['startDate'] as String)
          : null,
      endDate: map['endDate'] != null
          ? DateFormat('yyyy-MM-dd').parse(map['endDate'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Book(id: $id, category: $category, title: $title, series: $series, volume: $volume, author: $author, publisher: $publisher, price: $price, isbn: $isbn, wishlist: $wishlist, gift: $gift, borrow: $borrow, releaseDate: $releaseDate, payDate: $payDate, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Book &&
        other.id == id &&
        other.category == category &&
        other.title == title &&
        other.series == series &&
        other.volume == volume &&
        other.author == author &&
        other.publisher == publisher &&
        other.price == price &&
        other.isbn == isbn &&
        other.wishlist == wishlist &&
        other.gift == gift &&
        other.borrow == borrow &&
        other.releaseDate == releaseDate &&
        other.payDate == payDate &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        category.hashCode ^
        title.hashCode ^
        series.hashCode ^
        volume.hashCode ^
        author.hashCode ^
        publisher.hashCode ^
        price.hashCode ^
        isbn.hashCode ^
        wishlist.hashCode ^
        gift.hashCode ^
        borrow.hashCode ^
        releaseDate.hashCode ^
        payDate.hashCode ^
        startDate.hashCode ^
        endDate.hashCode;
  }
}
