// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_app/src/core/constants/colors.dart';
import 'package:mobile_app/src/data/models/invitation.dart';
import 'package:mobile_app/src/data/models/payload/noti_resp.dart';
import 'package:mobile_app/src/data/services/auth_service.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();

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
      backgroundColor: Bg,
      appBar: projectAppBar(),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/girl.jpg"), fit: BoxFit.cover),
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
              ))),
    );
  }
}

class _NotificationPageState extends State<NotiPage> {
  late Future<List<NotificationCustom>> notification;
  late Future<List<Invitation>> invitation;

  @override
  void initState() {
    super.initState();
    notification = AuthService.listNoti();
    invitation = AuthService.listInvi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Bg,
      appBar: AppBar(
          backgroundColor: Color(0xff2d5f79), title: Text("Notification")),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: FutureBuilder<List<Invitation>>(
                future: invitation,
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data!.length == 0) {
                    return SizedBox.shrink();
                  }
                  var data = snapshot.data!;
                  return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(data[index].toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                acceptIcon(data[index].id!),
                                denyIcon(data[index].id!)
                              ],
                            ),
                          ),
                        );
                      });
                }),
          ),
          Expanded(
            child: FutureBuilder<List<NotificationCustom>>(
                future: notification,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return SizedBox.shrink();
                  }
                  var data = snapshot.data!;
                  return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(data[index].toString()),
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }

  Widget acceptIcon(int id) {
    return IconButton(
        color: Colors.green,
        onPressed: () async {
          var rs = await AuthService.acceptInvitation("ACCEPT", id);
          if (rs.code == "SUCCESS") {
            customSnackBar('Join', "Success",
                iconData: Icons.check_outlined, iconColor: Colors.green);
          } else {
            customSnackBar('Join', "Error",
                iconData: Icons.warning_rounded, iconColor: Colors.red);
          }
        },
        icon: const Icon(Icons.check_rounded));
  }

  Widget denyIcon(int id) {
    return IconButton(
        color: Colors.red,
        onPressed: () async {
          var rs = await AuthService.acceptInvitation("DENY", id);
          if (rs.code == "SUCCESS") {
            customSnackBar('Join', "Success",
                iconData: Icons.check_outlined, iconColor: Colors.green);
          } else {
            customSnackBar('Join', "Error",
                iconData: Icons.warning_rounded, iconColor: Colors.red);
          }
        },
        icon: const Icon(Icons.close_rounded));
  }
}
