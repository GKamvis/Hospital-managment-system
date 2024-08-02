import 'package:flutter/material.dart';
import 'package:hospital_managment_system/Dashboard/DashboardScreen.dart';
import 'package:hospital_managment_system/screens/main/side_menu.dart';

import '../../responsive.dart';
import '../screens/dashboard/dashboard_screen.dart';
import 'SideMenu.dart';

class Mainscreenfordashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenuDashboard(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Dashboard1(),
            ),
          ],
        ),
      ),
    );
  }
}
