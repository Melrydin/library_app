import 'package:flutter/material.dart';

import '../global.dart';

Widget buildTextField(String label, String hint, TextInputType keys, TextEditingController controller) {
  return TextFormField(
    decoration: InputDecoration(
      hintStyle: TextStyle(color: redColor),
      labelText: label,
      labelStyle: TextStyle(color: redColor),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: redColor), borderRadius: BorderRadius.circular(10.0)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: redColor), borderRadius: BorderRadius.circular(10.0)),
      hintText: hint,
    ),
    keyboardType: keys,
    controller: controller,
    style: TextStyle(color: redColor, fontFamily: "Avenir"),
    cursorColor: redColor,
  );
}
