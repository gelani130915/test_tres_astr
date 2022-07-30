import 'package:flutter/material.dart';

class OtherPage extends StatelessWidget {
  String text;
  OtherPage({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/img/astronautas.png'),
        Text(
          text,
          style: const TextStyle(
            fontSize: 20
          ),
        )
      ],
    );
  }
}