// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

// class HomePage extends GetView<HomeController> {
//   HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("This is Home Page"));
//   }
// }


class Product {
  final image;
  final name;
  final price;

  Product(this.image, this.name, this.price);
}

class HomePage extends GetView {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: AppBar(
        title: Text('Buyings'),
      ),
      body: Text("Home")
    );
  }
}