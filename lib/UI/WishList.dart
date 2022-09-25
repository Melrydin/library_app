import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/UI/NavigationWidget.dart';
import 'package:library_app/UI/NewBookPage.dart';
import 'package:library_app/databaseHelper.dart';
import 'package:library_app/models/global.dart';
import 'package:library_app/networking.dart';

import '../models/global.dart';
import '../models/widgets/book.dart';
import '../models/widgets/bookCards.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  late List<Book> books;
  bool isLoading = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    if (currentIndex == 0) {
      refreshBooks("Manga");
    } else if (currentIndex == 1) {
      refreshBooks("Novel");
    } else if (currentIndex == 2) {
      refreshBooks("Technical");
    }
  }

  Future refreshBooks(String category) async {
    setState(() {
      isLoading = true;
    });

    books = await networking.libraryOrWishList(true, category);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Wish List'),
        backgroundColor: darkGreyColor,
      ),
      body: Container(
        color: darkGreyColor,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : books.isEmpty
                  ? Text(
                      "Not Books",
                      style: redNotBooks,
                    )
                  : ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        return BookCard(
                          book: books[index],
                          from: 1,
                        );
                      },
                    ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: redColor,
        selectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            if (currentIndex == 0) {
              refreshBooks("Manga");
            } else if (currentIndex == 1) {
              refreshBooks("Novel");
            } else if (currentIndex == 2) {
              refreshBooks("Technical");
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.book),
            label: 'Manga',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.book),
            label: 'Novel',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.book),
            label: 'Technical',
          ),
        ],
        backgroundColor: darkGreyColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewBookPage(
                inEditMode: 0,
                from: 1,
              ),
            ),
          );
        },
        backgroundColor: Colors.red,
        child: Icon(FontAwesomeIcons.plus, color: darkGreyColor),
      ),
    );
  }
}
