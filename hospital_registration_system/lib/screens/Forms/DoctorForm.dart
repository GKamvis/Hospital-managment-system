import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class DoctorPage extends StatefulWidget {
  DoctorPage({Key? key}) : super(key: key);
  @override
  State<DoctorPage> createState() => _DoctorPageState();
}
class _DoctorPageState extends State<DoctorPage> {
  List<Team> teams = [];

  final TextEditingController nameController = TextEditingController();

  final TextEditingController surnameController = TextEditingController();

  final TextEditingController specialtyController = TextEditingController();

  final TextEditingController roomNumberController = TextEditingController();

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

  Future<void> addTeam(Team team) async {
    try {
      var response = await http.post(
        Uri.https('localhost:7000', '/api/Doctors'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(team.toJson()),
      );

      if (response.statusCode == 201) {
        print('Team added successfully');
        // Yeni komanda əlavə olunduqdan sonra yenidən komandaları yükləyək
        getTeams();
      } else {
        print('Failed to add team. Status code: ${response.statusCode}');
        print('Response body: ${response.body}'); // Daha ətraflı məlumat üçün
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
  Future<void> deleteTeam(int id) async {
    try {
      var response = await http.delete(
        Uri.https('localhost:7000', '/api/Doctors/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Team deleted successfully');
        setState(() {
          teams.removeWhere((team) => team.DoctorId == id);
        });
      } else {
        print('Failed to delete team. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }



  void _showAddTeamDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yeni Həkim Əlavə Et'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Adı'),
              ),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(labelText: 'Soyadı'),
              ),
              TextField(
                controller: specialtyController,
                decoration: InputDecoration(labelText: 'İxtisası'),
              ),
              TextField(
                controller: roomNumberController,
                decoration: InputDecoration(labelText: 'Otaq Nömrəsi'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ləğv et'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Əlavə et'),
              onPressed: () {

                final newTeam = Team(
                  DoctorName: nameController.text,
                  DoctorSurname: surnameController.text,
                  DoctorSpecialty: specialtyController.text,
                  DoctorId: null, // This will be assigned by the server
                  DoctorRoomNumber: int.tryParse(roomNumberController.text) ?? 0,

                );
                setState((){
                  addTeam(newTeam);
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.blue[900],
      body: FutureBuilder(
        future: getTeams(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (teams.isNotEmpty) {
              return ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed:() {
                              setState(() {
                                deleteTeam(teams[index].DoctorId!);
                              });
                            }
                        ),
                        title: Text(teams[index].DoctorName + teams[index].DoctorSurname),
                        subtitle: Text("Otaq nömrəsi : " + teams[index].DoctorRoomNumber.toString() + "  Ixtisasi :  " + teams[index].DoctorSpecialty),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('Heç bir həkim yoxdur'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTeamDialog(context);
        },
        child: Icon(Icons.add),
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
