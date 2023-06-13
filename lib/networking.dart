import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:library_app/models/widgets/book.dart';

class networking {
  static String url = "http://172.16.0.58:5000/";

  static Future addBook(Book book) async {
    final String addBookUrl = "${url}add/";
    final response = await http.post(
      Uri.parse(addBookUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(book.toMap()),
    );
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      return Book.fromJson(responseBody);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future getBook(int bookId) async {
    final String getBookUrl = "${url}getBook/$bookId";
    final response = await http.get(Uri.parse(getBookUrl));
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      return Book.fromJson(responseBody);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future libraryOrWishList(bool type, String category) async {
    late List<Book> books = [];
    final String libraryOrWishListUrl =
        "${url}libraryOrWishlist/$type&$category";
    final response = await http.get(Uri.parse(libraryOrWishListUrl));
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonResponse = json.decode(responseBody);
      for (var book in jsonResponse) {
        books.add(Book.fromMap(book));
      }
      return books;
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future updateBook(Book book) async {
    final String updateBookUrl = "${url}update/%7BbookId%7D?book_id=${book.id}";
    final response = await http.post(
      Uri.parse(updateBookUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(book.toMap()),
    );
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      return Book.fromJson(responseBody);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future delete(int id) async {
    final String deleteBookUrl = "${url}delete/%7BbookId%7D?book_id=${id}";
    final response = await http.delete(Uri.parse(deleteBookUrl));
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      return responseBody;
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future allPay() async {
    final String yearPayUrl = "${url}allPay";
    final response = await http.get(Uri.parse(yearPayUrl));
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      return double.parse(responseBody);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future years() async {
    final String yearPayUrl = "${url}yearsInTable";
    final response = await http.get(Uri.parse(yearPayUrl));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<int> years = [];
      for (int i = 0; i < responseBody.length; i++) {
        years.add(responseBody[i]['Year']);
      }
      return years;
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<double> yearPay(int year) async {
    final String yearPayUrl = "${url}yearPay/${year}";
    final response = await http.get(Uri.parse(yearPayUrl));
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      return double.parse(responseBody);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future wishOrLibrary() async {
    final String wishOrLibraryUrl = "${url}trueAndFalseCounter";
    final response = await http.get(Uri.parse(wishOrLibraryUrl));
    if (response.statusCode == 200) {
      List<int> wishOrLibrary = [];
      final responseBody = json.decode(response.body);
      wishOrLibrary.add(responseBody['true']);
      wishOrLibrary.add(responseBody['false']);
      wishOrLibrary.add(responseBody['gift']);
      return wishOrLibrary;
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future borrow(String category) async {
    late List<Book> books = [];
    final String borrowUrl = "${url}borrow/$category";
    final response = await http.get(Uri.parse(borrowUrl));
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonResponse = json.decode(responseBody);
      for (var book in jsonResponse) {
        books.add(Book.fromMap(book));
      }
      return books;
    } else {
      throw Exception('Failed to load post');
    }
  }
}