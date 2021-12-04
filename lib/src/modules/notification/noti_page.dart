import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/data/models/payload/noti_resp.dart';
import 'package:mobile_app/src/data/services/auth_service.dart';
import 'package:mobile_app/src/global_widgets/custom_snackbar.dart';
import 'noti_controller.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotiPage> {
  late Future<List<NotificationCustom>> notification;

  @override
  void initState() {
    super.initState();
    notification = AuthService.listNoti();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification")),
      body: FutureBuilder<List<NotificationCustom>>(
          future: notification,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }
            var data = snapshot.data!;
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(data[index].toString()),
                      subtitle: Text(data[index].doerUsername),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          acceptIcon(data[index].message),
                          denyIcon(data[index].message)
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }

  Widget acceptIcon(String mes) {
    if (mes.contains("You have an invitation to project")) {
      return IconButton(
          color: Colors.green,
          onPressed: () async {
            var rs = await AuthService.acceptInvitation("ACCEPT");
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
    return const SizedBox.shrink();
  }

  Widget denyIcon(String mes) {
    if (mes.contains("You have an invitation to project")) {
      return IconButton(
          color: Colors.red,
          onPressed: () async {
            var rs = await AuthService.acceptInvitation("DENY");
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
    return const SizedBox.shrink();
  }
}
