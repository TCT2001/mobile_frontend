import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({Key? key}) : super(key: key);

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  @override
  Widget build(BuildContext context) {
    int id = Get.arguments['id'];
    return Scaffold(
        appBar: AppBar(title: Text("Project Detail Page")),
        body: Center(
            child: Text(
                'Id: $id, tu do dung findById de lay du lieu cua Project Nay Ra')));
  }
}
