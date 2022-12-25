import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_app/UI/Library.dart';
import 'package:library_app/UI/Statistics.dart';
import 'package:library_app/UI/WishList.dart';
import 'package:library_app/main.dart';
import 'package:library_app/models/global.dart';

import 'BorrowPage.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: darkGreyColor,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 16),
            buildMenuItem(
              text: "Home",
              icon: FontAwesomeIcons.house,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: "Library",
              icon: FontAwesomeIcons.book,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: "Wish List",
              icon: FontAwesomeIcons.heart,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: "Borrow",
              icon: FontAwesomeIcons.peopleArrowsLeftRight,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: "Statistics",
              icon: FontAwesomeIcons.chartPie,
              onClicked: () => selectedItem(context, 4),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int idex) {
    switch (idex) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => const LibraryApp())));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => const LibraryPage())));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => const WishListPage())));
        break;
      case 3:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => const BorrowPage())));
        break;
      case 4:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => const StatisticsPage())));
        break;
    }
  }
}
