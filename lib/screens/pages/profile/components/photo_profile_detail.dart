import 'package:flutter/material.dart';

class PhotoProfileDetail extends StatelessWidget {
  Widget img;
  PhotoProfileDetail({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Center(child: Hero(tag: "PhotoProfile", child: img)),
      ),
    );
  }
}
