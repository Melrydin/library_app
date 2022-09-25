import 'package:flutter/material.dart';

import 'UI/home.dart';

void main() => runApp(const LibraryApp());

class LibraryApp extends StatelessWidget {
  const LibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}
