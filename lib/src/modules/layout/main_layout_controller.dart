// ignore_for_file: unnecessary_this

import 'package:get/get.dart';

class MainLayoutController extends GetxController {
   final _index = 0.obs;
  get index => this._index.value;
  set index(value) => this._index.value = value;

  void changeIndex(int index) {
    this.index = index;
  }
}
