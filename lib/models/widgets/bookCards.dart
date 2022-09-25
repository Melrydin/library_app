import 'package:flutter/material.dart';
import 'package:library_app/UI/NewBookPage.dart';
import 'package:library_app/models/global.dart';
import 'package:library_app/models/widgets/book.dart';

import 'converter.dart';

class BookCard extends StatefulWidget {
  const BookCard({
    Key? key,
    required this.from,
    required this.book,
  }) : super(key: key);

  final Book book;
  final int from;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewBookPage(
              book: widget.book,
              inEditMode: 1,
              from: widget.from,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
        padding: const EdgeInsets.all(10),
        height: 130,
        decoration: BoxDecoration(
          color: widget.book.gift ? greyColor : redColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 370,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.book.title,
                      style: darkBookTitle,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: darkGreyColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "ISBN: ${isbnFormat(widget.book.isbn)}",
                      style: darkBookAuthor,
                    ),
                    Text(
                      "Author: ${widget.book.author}",
                      style: darkBookAuthor,
                    ),
                    Text(
                      "Publisher: ${widget.book.publisher}",
                      style: darkBookAuthor,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            "Band: ${widget.book.volume == 0 ? "-" : widget.book.volume}",
                            style: darkBookAuthor),
                        if (widget.book.wishlist == true) ...[
                          Text(
                            "Relase: ${dateToString(widget.book.releaseDate)}",
                            style: darkBookAuthor,
                          ),
                          Text(
                            "Price: ${widget.book.price}€",
                            style: darkBookAuthor,
                          ),
                        ],
                        if (widget.book.wishlist == false) ...[
                          Text(
                            "Start: ${dateToString(widget.book.startDate)}",
                            style: darkBookAuthor,
                          ),
                          Text(
                            "End:   ${dateToString(widget.book.endDate)}",
                            style: darkBookAuthor,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
