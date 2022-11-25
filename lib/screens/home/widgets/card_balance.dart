import 'package:flutter/material.dart';

class CardBalance extends StatelessWidget {
  const CardBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        //boxShadow: BoxShadow(),
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.black87,
      ),
    );
  }
}
