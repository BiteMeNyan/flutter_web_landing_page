import 'package:flutter/material.dart';

import '../../config/style.dart';

class BlackButton extends StatelessWidget {
  const BlackButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Text(
          label,
          style: h4TextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
