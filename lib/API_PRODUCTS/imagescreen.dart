import 'package:flutter/material.dart';

// ignore: must_be_immutable
class imagescreen extends StatefulWidget {
  Image img;
  imagescreen({super.key, required this.img});

  @override
  State<imagescreen> createState() => _imagescreenState();
}

class _imagescreenState extends State<imagescreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Full Image"),
          backgroundColor: Colors.amber,
        ),
        body: Center(
          child: Container(
            child: widget.img,
          ),
        ),
      ),
    );
  }
}
