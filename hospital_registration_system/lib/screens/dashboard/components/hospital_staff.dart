import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;

class HospitalStaff extends StatefulWidget {
  const HospitalStaff({Key? key}) : super(key: key);

  @override
  State<HospitalStaff> createState() => _HospitalStaffState();
}

class _HospitalStaffState extends State<HospitalStaff> {
  List<Team> teams = [];


  Future<void> getTeams() async {
    try {
      var response = await http.get(Uri.https('localhost:7000', '/api/Doctors'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print('Response data: $jsonData'); // Debug: Print response data
        for (var eachTeam in jsonData) {
          final team = Team(
            DoctorName: eachTeam['doctorName'],
            DoctorSurname: eachTeam['doctorSurname'],
            DoctorSpecialty: eachTeam['doctorSpecialty'],
            DoctorId: int.tryParse(eachTeam['doctorId'].toString()) ?? 0,
            DoctorRoomNumber: int.tryParse(eachTeam['doctorRoomNumber'].toString()) ?? 0,
          );
          teams.add(team);
        }
        print('Teams loaded: ${teams.length}'); // Debug: Print number of teams loaded
      } else {
        // Handle error
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error occurred: $e');
    }
  }


  @override
  void initState() {
    super.initState();
    getTeams();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Doctors List",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 17.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 300.0,
            child: FutureBuilder<void>(
              future: getTeams(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (teams.isNotEmpty) {
                    return ListView.builder(
                      itemCount: teams.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        Team Teams = teams[index];
                        return Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          height: 300.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                ' "Dr" ${Teams.DoctorName} ${Teams.DoctorSurname}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),

                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No data available'));
                  }
                } else {
                  return Center(child: Text('Error loading data'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


class Team {
  final String DoctorName;
  final String DoctorSurname;
  final String DoctorSpecialty;
  final int? DoctorId; // optional, nullable
  final int DoctorRoomNumber;

  Team({
    required this.DoctorName,
    required this.DoctorSurname,
    required this.DoctorSpecialty,
    this.DoctorId, // optional
    required this.DoctorRoomNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'doctorName': DoctorName,
      'doctorSurname': DoctorSurname,
      'doctorSpecialty': DoctorSpecialty,
      'doctorRoomNumber': DoctorRoomNumber,
      // 'doctorId': DoctorId, // remove this line
    };
  }
}
