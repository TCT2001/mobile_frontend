import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'noti_controller.dart';

class NotiPage extends GetView<NotiController> {
  const NotiPage({Key? key}) : super(key: key);

 @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
         decoration: const BoxDecoration(
           gradient: LinearGradient(
               begin: Alignment.topRight,
               end: Alignment.bottomLeft,
               colors: [Colors.blueGrey, Colors.lightBlueAccent]),
         ),
         child: Padding(
             padding: const EdgeInsets.all(115),

             child: SizedBox(
               height: MediaQuery.of(context).size.height,
               child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: const [
                     Text("This is notification pagesss",
                         style: TextStyle(
                             color: Color(0xff88e8f2),
                             fontWeight: FontWeight.bold,
                             fontSize: 18)),
                     SizedBox(height: 8),

                     SizedBox(height: 8),


                   ]),
             )
         )),
   )
   ;
 }
}

