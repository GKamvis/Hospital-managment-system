import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../constants.dart';
import '../../../responsive.dart';
import 'header.dart';

class PatientsDetails extends StatefulWidget {
  const PatientsDetails({Key? key}) : super(key: key);

  @override
  State<PatientsDetails> createState() => _PatientsDetailsState();
}

class _PatientsDetailsState extends State<PatientsDetails> {
  List<Team> teams = [];
  List<Team> filteredTeams = [];
  late Future<void> futurePatients;
  TextEditingController searchController = TextEditingController();

  Future<void> getTeams() async {
    try {
      var response = await http.get(Uri.https('localhost:7000', '/api/Patient'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print('Response data: $jsonData'); // Debug: Print response data

        List<Team> loadedTeams = [];
        for (var eachTeam in jsonData) {
          final team = Team(
            PatientName: eachTeam['patientName'],
            PatientSurname: eachTeam['patientSurname'],
            PatientAppeal: eachTeam['patientAppeal'],
            PatientDoctor: eachTeam['patientDoctor'],
            PatientId: int.tryParse(eachTeam['patientId'].toString()) ?? 0,
            AnalysisId: int.tryParse(eachTeam['analysisId'].toString()) ?? 0,
          );
          loadedTeams.add(team);
        }
        setState(() {
          teams = loadedTeams;
          filteredTeams = teams;
        });
        print('Teams loaded: ${teams.length}'); // Debug: Print number of teams loaded
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  void filterTeams(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredTeams = teams;
      });
    } else {
      setState(() {
        filteredTeams = teams
            .where((team) =>
        team.PatientName.toLowerCase().contains(query.toLowerCase()) ||
            team.PatientSurname.toLowerCase().contains(query.toLowerCase()) ||
            team.PatientDoctor!.toLowerCase().contains(query.toLowerCase()) ?? false)
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    futurePatients = getTeams();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isMobile(context))
            Column(
              children: [
                textView(),
                SizedBox(
                  height: 10.0,
                ),
                SearchField(
                  controller: searchController,
                  onChanged: filterTeams,
                ),
              ],
            ),
          if (!Responsive.isMobile(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 3, child: textView()),
                Expanded(
                  flex: 5,
                  child: SearchField(
                    controller: searchController,
                    onChanged: filterTeams,
                  ),
                ),
              ],
            ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            height: 680,
            child: FutureBuilder<void>(
              future: futurePatients,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (filteredTeams.isNotEmpty) {
                    return DataTable2(
                      columnSpacing: defaultPadding,
                      headingRowHeight: defaultPadding * 5,
                      minWidth: 600,
                      decoration: BoxDecoration(color: Color(0xFF2CABB8)),
                      columns: [
                        DataColumn(
                          label: Text("Patient Name"),
                        ),
                        DataColumn(
                          label: Text("Patient Last Name"),
                        ),
                        DataColumn(
                          label: Text("Doctor"),
                        ),
                      ],
                      rows: List.generate(
                        filteredTeams.length,
                            (index) => patientDataRow(filteredTeams[index]),
                      ),
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

DataRow patientDataRow(Team patient) {
  return DataRow(
    cells: [
      DataCell(Text(patient.PatientName)),
      DataCell(Text(patient.PatientSurname)),
      DataCell(Text(patient.PatientDoctor ?? '')),
    ],
  );
}

Widget textView() => Text(
  "Patients",
  style: TextStyle(
      color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17.0),
);

class Team {
  final String PatientName;
  final String PatientSurname;
  final String? PatientAppeal;
  final String? PatientDoctor;
  final int? PatientId; // optional, nullable
  final int? AnalysisId;

  Team({
    required this.PatientName,
    required this.PatientSurname,
    required this.PatientAppeal,
    required this.PatientDoctor,
    this.PatientId, // optional
    required this.AnalysisId,
  });

  Map<String, dynamic> toJson() {
    return {
      'patientName': PatientName,
      'patientSurname': PatientSurname,
      'patientAppeal': PatientAppeal,
      'patientDoctor': PatientDoctor,
      'analysisId': AnalysisId,
    };
  }
}
