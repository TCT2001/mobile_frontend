import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobile_app/src/routes/app_routes.dart';
import 'package:line_icons/line_icons.dart';



Widget Narbar({required int selectedIndex}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 20,
          color: Colors.black.withOpacity(.1),
        )
      ],
    ),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[100]!,
          gap: 8,
          activeColor: Colors.black,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: Colors.grey[100]!,
          color: Colors.black,
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.tasks,
              text: 'Tasks',
            ),
            GButton(
              icon: LineIcons.search,
              text: 'Search',
            ),
            GButton(
              icon: LineIcons.bell,
              text: 'Notifications',
            ),
          ],
          selectedIndex: selectedIndex,
          onTabChange: (index) {
            print(index);
            switch (index) {
              case 0:
                Get.offAllNamed(Routes.HOME);
                break;
              case 1:
                // do something else
                break;
              case 2:
                // do something else
                break;
              case 3:
                // do something else
                Get.offAllNamed(Routes.NOTIFICATION);
                break;
            }
            //setState(() {
            //_selectedIndex = index;
            //});
          },
        ),
      ),
    ),
  );
}
