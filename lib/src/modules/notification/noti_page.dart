import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'noti_controller.dart';

class NotiPage extends GetView<NotiController> {
  const NotiPage({Key? key}) : super(key: key);



  AppBar? projectAppBar() {
    return AppBar(
      title: const Text('Notifications'),
      automaticallyImplyLeading: false,
      actionsIconTheme:
      IconThemeData(size: 30.0, color: Colors.white, opacity: 10.0),
      leading: GestureDetector(
        onTap: () {/* Write listener code here */},
        child: Icon(
          Icons.menu, // add custom icons also
        ),
      ),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.search,
                size: 26.0,
              ),
            )),
      ],
      backgroundColor: const Color(0xff2d5f79),

    );

  }

 @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: projectAppBar(),
     body: Container(
         decoration: const BoxDecoration(
           image: DecorationImage(image: AssetImage("assets/images/girl.jpg"), fit: BoxFit.cover),

         ),

         child: Padding(
             padding: const EdgeInsets.all(130),

             child: SizedBox(
               height: MediaQuery.of(context).size.height,
               child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: const [
                     Text("Notification page",
                         style: TextStyle(
                             color: Color(0xff88e8f2),
                             fontWeight: FontWeight.bold,
                             fontSize: 20)),
                     SizedBox(height: 28),

                     SizedBox(height: 28),


                   ]),
             )
         )),
   )
   ;
 }
}

