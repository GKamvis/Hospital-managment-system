import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_managment_system/screens/dashboard/components/dead_patient.dart';
import 'package:hospital_managment_system/screens/dashboard/components/patients_details.dart';
import 'package:hospital_managment_system/screens/dashboard/components/recover_patient.dart';

import '../../constants.dart';
import '../../responsive.dart';
import 'components/hospital_staff.dart';


class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController searchController = TextEditingController();

  void filterTeams(String query) {
    // Here you need to add the logic to filter the teams or patients list
    // Since we don't have direct access to the PatientsDetails component's state,
    // you might need to use a state management solution like Provider or Bloc.
    print("Search query: $query"); // For now, just print the query
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.person , color: Colors.blue,),
                Text(' ${user.email!}                     ' , style: TextStyle(color: Colors.black , fontSize: 20),),

                Text("Logout " , style: TextStyle(color: Colors.black),),
                IconButton(onPressed: FirebaseAuth.instance.signOut, icon: Icon(Icons.logout , size: 30,)),
              ],
            ),


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

                      Text("bu 1 ci ekrandır"),
                  //    MyStaff(),
                    //  SizedBox(height: defaultPadding),
                    //  HospitalSurvey(),
                      SizedBox(
                        height: 20.0,
                      ),
                      if (!Responsive.isMobile(context))
                        Row(
                          children: [
                            Expanded(flex: 6, child: PatientsDetails()),
                            SizedBox(width: defaultPadding),
                            Expanded(
                                flex: 4,
                                child: Column(
                                  children: [
                                 //   RecoveryReports(),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                   // DeathReports()
                                  ],
                                ))
                          ],
                        ),
                      if (Responsive.isMobile(context)) PatientsDetails(),
                      if (Responsive.isMobile(context))
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: RecoveryReports(),
                        ),
                      if (Responsive.isMobile(context))
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: DeathReports(),
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
    );
  }
}
