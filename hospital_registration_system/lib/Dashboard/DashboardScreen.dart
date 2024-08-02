import 'package:flutter/material.dart';
import 'package:hospital_managment_system/screens/dashboard/components/dead_patient.dart';
import 'package:hospital_managment_system/screens/dashboard/components/patients_details.dart';
import 'package:hospital_managment_system/screens/dashboard/components/recover_patient.dart';

import '../../constants.dart';
import '../../responsive.dart';
import '../screens/dashboard/components/hospital_staff.dart';
import '../screens/dashboard/components/my_staff.dart';
import '../screens/dashboard/components/survey.dart';
import '../screens/main/side_menu.dart';
import 'SideMenu.dart';

class Dashboard1 extends StatefulWidget {
  @override
  _Dashboard1State createState() => _Dashboard1State();
}

class _Dashboard1State extends State<Dashboard1> {
  TextEditingController searchController = TextEditingController();

  void filterTeams(String query) {
    // Here you need to add the logic to filter the teams or patients list
    // Since we don't have direct access to the PatientsDetails component's state,
    // you might need to use a state management solution like Provider or Bloc.
    print("Search query: $query"); // For now, just print the query
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:SideMenuDashboard(),

      body: SafeArea(

        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              //SideMenuDashboard(),
              IconButton(onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }, icon: Icon(Icons.logout , size: 30 , color: Colors.black,) , ),
              //   Header(
              //  controller: searchController,
              //  onChanged: filterTeams,
              // ),
              //   SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                           // MyStaff(),
                         SizedBox(height: defaultPadding),
                          HospitalSurvey(),
                        SizedBox(
                          height: 20.0,
                        ),
                        if (!Responsive.isMobile(context))
                          Row(
                            children: [
                            // Expanded(flex: 6, child: PatientsDetails()),
                              SizedBox(width: defaultPadding),
                              Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                    //  RecoveryReports(),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                    //  DeathReports()
                                    ],
                                  ))
                            ],
                          ),
                        //if (Responsive.isMobile(context)) PatientsDetails(),
                       // if (Responsive.isMobile(context))
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            //child: RecoveryReports(),
                          ),
                        if (Responsive.isMobile(context))
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                           // child: DeathReports(),
                          ),
                        HospitalStaff()
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
