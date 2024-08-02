import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hospital_managment_system/screens/Forms/DoctorForm.dart';
import 'package:hospital_managment_system/screens/Forms/NurseForm.dart';
import 'package:hospital_managment_system/screens/Forms/PatientForm.dart';
import '../../Auth/PasswordScreen.dart';
import '../../Kassa/paymentservice.dart';
import '../../constants.dart';
class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Admin Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => const HomeScreen(),
              //   ),
              // );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>  PasswordScreen(),
                ),
              );
            },
          ),
          DrawerListTile(
            title: "Patient Form",
            svgSrc: "assets/icons/forms.svg",
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>  PatientPage(),
                ),
              );

            },
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>  PaymentScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: primaryColor,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: primaryColor),
      ),
    );
  }
}
