import 'package:flutter/material.dart';

Widget pocButton(String pButtonText, void Function() onPress) {
  return InkWell(
    onTap: onPress,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      color: Colors.green,
      height: 55,
      child: Center(child: Text(pButtonText)),
    ),
  );
}
