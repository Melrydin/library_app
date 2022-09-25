import 'package:flutter/material.dart';

import '../models/global.dart';
import 'NavigationWidget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String _title = 'Library App';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: darkGreyColor,
        title: const Text(_title),
      ),
      body: Container(
        color: darkGreyColor,
        child: Center(
          child: Text('Home', style: redNotBooks),
        ),
      ),
    );
  }
}
