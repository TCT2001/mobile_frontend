import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_app/src/core/constants/colors.dart';

class LoadingWidget extends Container {
  LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitSquareCircle(
      color: neruColor,
    );
  }
}
