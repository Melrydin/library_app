import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:library_app/UI/BorrowPage.dart';
import 'package:library_app/UI/Library.dart';
import 'package:library_app/UI/WishList.dart';

import 'package:library_app/networking.dart';

import 'package:library_app/models/global.dart';
import 'package:library_app/models/widgets/buttons.dart';
import 'package:library_app/models/widgets/converter.dart';
import 'package:library_app/models/widgets/book.dart';

class NewBookPage extends StatefulWidget {
  final int inEditMode;
  final Book? book;
  final int from;

  const NewBookPage({
    required this.inEditMode,
    this.book,
    required this.from,
    Key? key,
  }) : super(key: key);

  @override
  State<NewBookPage> createState() => _NewBookPageState();
}

class _NewBookPageState extends State<NewBookPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> category = ["Manga", "Novel", "Technical"];
  final List<String> wishlist = ["true", "false"];
  String? selectedCategoryItem = "Manga";
  bool? selectedWishItem = true;
  bool? selectedGiftItem = false;
  bool? selectedSeries = false;
  bool? selectedBorrow = false;
  late Book? book;
  final double height = 60;
  bool isLoading = false;
  final TextEditingController _titleController =
      TextEditingController(text: "");
  final TextEditingController _volumeInfoController =
      TextEditingController(text: "");
  final TextEditingController _authorController =
      TextEditingController(text: "");
  final TextEditingController _publisherController =
      TextEditingController(text: "");
  final TextEditingController _isbnController =
      TextEditingController(text: "9783");
  final TextEditingController _releaseDateController =
      TextEditingController(text: "");
  final TextEditingController _payDateController =
      TextEditingController(text: "");
  final TextEditingController _priceController =
      TextEditingController(text: "");
  final TextEditingController _startDateController =
      TextEditingController(text: "");
  final TextEditingController _endDateController =
      TextEditingController(text: "");

  @override
  void initState() {
    super.initState();

    if (widget.inEditMode == 1) {
      setState(
        () {
          selectedCategoryItem = widget.book!.category;
          _titleController.text = widget.book!.title;
          selectedSeries = widget.book!.series;
          _volumeInfoController.text = widget.book!.volume.toString();
          _authorController.text = widget.book!.author;
          _publisherController.text = widget.book!.publisher;
          _priceController.text = widget.book!.price.toString();
          _isbnController.text = widget.book!.isbn.toString();
          selectedWishItem = widget.book!.wishlist;
          selectedGiftItem = widget.book!.gift;
          selectedBorrow = widget.book!.borrow;
          _releaseDateController.text = widget.book!.releaseDate == null
              ? ""
              : DateFormat('dd.MM.yyyy').format(widget.book!.releaseDate!);
          _payDateController.text = widget.book!.payDate == null
              ? ""
              : DateFormat('dd.MM.yyyy').format(widget.book!.payDate!);
          _startDateController.text = widget.book!.startDate == null
              ? ""
              : DateFormat('dd.MM.yyyy').format(widget.book!.startDate!);
          _endDateController.text = widget.book!.endDate == null
              ? ""
              : DateFormat('dd.MM.yyyy').format(widget.book!.endDate!);
        },
      );
    }
    if (widget.inEditMode == 2) {
      setState(
        () {
          selectedCategoryItem = widget.book!.category;
          _titleController.text = widget.book!.title;
          selectedSeries = widget.book!.series;
          _authorController.text = widget.book!.author;
          _publisherController.text = widget.book!.publisher;
        },
      );
    }
  }

  void addOrUpdateBook() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = book != null;

      if (isUpdating) {
        await updateBook();
      } else {
        await addBook();
      }
      Navigator.pop(context);
    }
  }

  Future updateBook() async {
    final book = Book(
      id: widget.book!.id,
      category: selectedCategoryItem.toString(),
      title: _titleController.text,
      series: selectedSeries == false ? false : true,
      volume: int.parse(
          _volumeInfoController.text == "" ? "0" : _volumeInfoController.text),
      author: _authorController.text,
      publisher: _publisherController.text,
      price: double.parse(_priceController.text),
      isbn: int.parse(_isbnController.text),
      wishlist: selectedWishItem == false ? false : true,
      gift: selectedGiftItem == false ? false : true,
      borrow: selectedBorrow == false ? false : true,
      releaseDate: stringToDate(_releaseDateController.text),
      payDate: stringToDate(_payDateController.text),
      startDate: stringToDate(_startDateController.text),
      endDate: stringToDate(_endDateController.text),
    );

    networking.updateBook(book);
  }

  Future addBook() async {
    final book = Book(
      category: selectedCategoryItem.toString(),
      title: _titleController.text,
      series: selectedSeries == false ? false : true,
      volume: int.parse(
          _volumeInfoController.text == "" ? "0" : _volumeInfoController.text),
      author: _authorController.text,
      publisher: _publisherController.text,
      price: double.parse(_priceController.text),
      isbn: int.parse(_isbnController.text),
      wishlist: selectedWishItem == false ? false : true,
      gift: selectedGiftItem == false ? false : true,
      borrow: selectedBorrow == false ? false : true,
      releaseDate: stringToDate(_releaseDateController.text),
      payDate: stringToDate(_payDateController.text),
      startDate: stringToDate(_startDateController.text),
      endDate: stringToDate(_endDateController.text),
    );

    networking.addBook(book);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle(widget.inEditMode)),
        backgroundColor: darkGreyColor,
        actions: <Widget>[
          if (widget.inEditMode == 1) ...[
            IconButton(
              icon: const Icon(FontAwesomeIcons.copy),
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewBookPage(
                      book: Book(
                          category: widget.book!.category,
                          title: widget.book!.title,
                          series: widget.book!.series,
                          volume: 0,
                          author: widget.book!.author,
                          publisher: _publisherController.text,
                          price: 0,
                          isbn: 9783,
                          wishlist: true,
                          gift: false,
                          borrow: false,
                          releaseDate: null,
                          payDate: null,
                          startDate: null,
                          endDate: null),
                      inEditMode: 2,
                      from: widget.from,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(FontAwesomeIcons.trash),
              onPressed: () async {
                networking.delete(widget.book!.id!);
                if (widget.from == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LibraryPage()),
                  ).then((value) => setState(() {}));
                } else if (widget.from == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WishListPage()),
                  ).then((value) => setState(() {}));
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BorrowPage()),
                  ).then((value) => setState(() {}));
                }
              },
            ),
          ],
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: darkGreyColor,
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: (width / 2) - 15,
                  height: height,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: redColor),
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: redColor),
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: "Category",
                      labelStyle:
                          TextStyle(color: redColor, fontFamily: "Avenir"),
                    ),
                    dropdownColor: darkGreyColor,
                    value: selectedCategoryItem,
                    items: category.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category,
                            style: TextStyle(
                                color: redColor, fontFamily: "Avenir")),
                      );
                    }).toList(),
                    onChanged: (item) {
                      setState(() => selectedCategoryItem = item);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: (width / 2) - 15,
                  height: height,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: redColor),
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: redColor),
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: "Wish List",
                      labelStyle:
                          TextStyle(color: redColor, fontFamily: "Avenir"),
                    ),
                    dropdownColor: darkGreyColor,
                    value: selectedWishItem == false ? "false" : "true",
                    items: wishlist.map((wishList) {
                      return DropdownMenuItem<String>(
                        value: wishList,
                        child: Text(wishList,
                            style: TextStyle(
                                color: redColor, fontFamily: "Avenir")),
                      );
                    }).toList(),
                    onChanged: (item) {
                      setState(() =>
                          selectedWishItem = item == "true" ? true : false);
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: (width / 2) - 15,
                  height: height,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: redColor),
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: redColor),
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: "Series",
                      labelStyle:
                          TextStyle(color: redColor, fontFamily: "Avenir"),
                    ),
                    dropdownColor: darkGreyColor,
                    value: selectedSeries == false ? "false" : "true",
                    items: wishlist.map((wishList) {
                      return DropdownMenuItem<String>(
                        value: wishList,
                        child: Text(wishList,
                            style: TextStyle(
                                color: redColor, fontFamily: "Avenir")),
                      );
                    }).toList(),
                    onChanged: (item) {
                      setState(
                          () => selectedSeries = item == "true" ? true : false);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: (width / 2) - 15,
                  height: height,
                  child: buildTextField("Volume Info", "0",
                      TextInputType.number, _volumeInfoController),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: (width / 2) - 15,
                  height: height,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: redColor),
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: redColor),
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: "Gift",
                      labelStyle:
                          TextStyle(color: redColor, fontFamily: "Avenir"),
                    ),
                    dropdownColor: darkGreyColor,
                    value: selectedGiftItem == false ? "false" : "true",
                    items: wishlist.map((wishList) {
                      return DropdownMenuItem<String>(
                        value: wishList,
                        child: Text(wishList,
                            style: TextStyle(
                                color: redColor, fontFamily: "Avenir")),
                      );
                    }).toList(),
                    onChanged: (item) {
                      setState(() =>
                          selectedGiftItem = item == "true" ? true : false);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: (width / 2) - 15,
                  height: height,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: redColor),
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: redColor),
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: "Borrowed",
                      labelStyle:
                          TextStyle(color: redColor, fontFamily: "Avenir"),
                    ),
                    dropdownColor: darkGreyColor,
                    value: selectedBorrow == false ? "false" : "true",
                    items: wishlist.map((wishList) {
                      return DropdownMenuItem<String>(
                        value: wishList,
                        child: Text(wishList,
                            style: TextStyle(
                                color: redColor, fontFamily: "Avenir")),
                      );
                    }).toList(),
                    onChanged: (item) {
                      setState(
                          () => selectedBorrow = item == "true" ? true : false);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            buildTextField(
                "Price", "7.99", TextInputType.number, _priceController),
            const SizedBox(height: 10),
            buildTextField(
                "Title", "New Title", TextInputType.text, _titleController),
            const SizedBox(height: 10),
            buildTextField(
                "Author", "New Author", TextInputType.text, _authorController),
            const SizedBox(height: 10),
            buildTextField("Publisher", "New Publisher", TextInputType.text,
                _publisherController),
            const SizedBox(height: 10),
            buildTextField(
                "ISBN", "123456789", TextInputType.number, _isbnController),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: (width / 2) - 15,
                    height: height,
                    child: buildTextField("Release Date", "01.01.2020",
                        TextInputType.number, _releaseDateController)),
                const SizedBox(width: 10),
                SizedBox(
                  width: (width / 2) - 15,
                  height: height,
                  child: buildTextField("Pay Date", "01.01.2020",
                      TextInputType.number, _payDateController),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: (width / 2) - 15,
                    height: height,
                    child: buildTextField("Start Date", "01.01.2020",
                        TextInputType.number, _startDateController)),
                const SizedBox(width: 10),
                SizedBox(
                    width: (width / 2) - 15,
                    height: height,
                    child: buildTextField("End Date", "01.01.2020",
                        TextInputType.number, _endDateController)),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: redColor,
                onPrimary: darkGreyColor,
              ),
              child: Text(widget.inEditMode == 1 ? "Update" : "Add"),
              onPressed: () async {
                if (widget.inEditMode == 1) {
                  await updateBook();
                } else {
                  await addBook();
                }
                _titleController.clear();
                _authorController.clear();
                _publisherController.clear();
                _priceController.clear();
                _isbnController.clear();
                _releaseDateController.clear();
                _payDateController.clear();
                _startDateController.clear();
                _endDateController.clear();
                if (widget.from == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LibraryPage()),
                  ).then((value) => setState(() {}));
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WishListPage()),
                  ).then((value) => setState(() {}));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
