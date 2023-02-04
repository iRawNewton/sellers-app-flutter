import 'package:flutter/material.dart';

Widget pdtextField({String? text, int? lines, TextInputType? keyboard}) {
  return TextField(
    keyboardType: keyboard,
    maxLines: lines,
    decoration: InputDecoration(
      hintText: text!,
      fillColor: Colors.white38,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Colors.white70),
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Colors.white70),
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  );
}
