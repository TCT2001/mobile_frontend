// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class InstructionsPage extends StatefulWidget {
  const InstructionsPage({Key? key}) : super(key: key);

  @override
  _InstructionsPageState createState() => _InstructionsPageState();
}

class _InstructionsPageState extends State<InstructionsPage> {

  var toDoList = ['Step 1','Step 2','Step 3','Step 4','Step 5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2d5f79),
        title: Text('Slider App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CarouselSlider(
            options: CarouselOptions(height:  500),
            items: ['assets/images/1.PNG','assets/images/2.PNG','assets/images/3.PNG','assets/images/4.PNG','assets/images/5.PNG'].map((i) {
              return Builder(
                  builder : (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin : EdgeInsets.symmetric(horizontal: 5.0),

                      child: Column(
                        children: [
                          Image.asset(i),
                          SizedBox( height:  10,),
                          if(i == 'assets/images/1.PNG')
                            Text("${toDoList[0]}", style:  TextStyle( fontSize: 25, fontWeight: FontWeight.w800),),
                          if(i == 'assets/images/2.PNG')
                            Text("${toDoList[1]}", style:  TextStyle( fontSize: 25, fontWeight: FontWeight.w800),),
                          if(i == 'assets/images/3.PNG')
                            Text("${toDoList[2]}", style:  TextStyle( fontSize: 25, fontWeight: FontWeight.w800),),
                          if(i == 'assets/images/4.PNG')
                            Text("${toDoList[3]}", style:  TextStyle( fontSize: 25, fontWeight: FontWeight.w800),),
                          if(i == 'assets/images/5.PNG')
                            Text("${toDoList[4]}", style:  TextStyle( fontSize: 25, fontWeight: FontWeight.w800),),
                        ],
                      ),

                    );
                  }
              );
            }).toList(),

          ),
        ),
      ),
    );
  }
}