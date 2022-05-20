import 'package:empat_landing/config/style.dart';
import 'package:flutter/material.dart';

class ShowCaseCursor extends StatefulWidget {
  const ShowCaseCursor({Key? key}) : super(key: key);

  @override
  _ShowCaseCursorState createState() => _ShowCaseCursorState();
}

class _ShowCaseCursorState extends State<ShowCaseCursor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: const Center(
        child: Text(
          'Show case',
          style: h5TextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
