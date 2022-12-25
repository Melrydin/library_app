import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/UI/NavigationWidget.dart';
import 'package:library_app/models/global.dart';
import 'package:library_app/models/widgets/bookCards.dart';
import 'package:library_app/networking.dart';

import '../databaseHelper.dart';
import '../models/widgets/book.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
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

    books = await networking.libraryOrWishList(false, category);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Library'),
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
                          from: 0,
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
    );
  }
}
