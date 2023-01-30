import 'package:flutter/material.dart';

// Widget pdtextField({String? text, int? lines}) {
//   return Container(
//     margin: const EdgeInsets.only(bottom: 20),
//     padding: const EdgeInsets.only(left: 10),
//     decoration: BoxDecoration(
//         color: Colors.white38,
//         border: Border.all(color: Colors.white70),
//         borderRadius: BorderRadius.circular(10)),
//     child: TextField(
//       maxLines: lines,
//       decoration: InputDecoration(
//         labelText: text,
//         border: InputBorder.none,
//       ),
//     ),
//   );
// }

Widget pdtextField({String? text, int? lines, TextInputType? keyboard}) {
  return TextField(
    keyboardType: TextInputType.number,
    maxLines: lines,
    decoration: InputDecoration(
      labelText: text!,
      fillColor: Colors.white38,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(width: 1, color: Colors.white70), //<-- SEE HERE
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(width: 1, color: Colors.white70), //<-- SEE HERE
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  );
}
