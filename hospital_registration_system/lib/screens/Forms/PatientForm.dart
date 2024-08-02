import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PatientPage extends StatefulWidget {
  PatientPage({Key? key}) : super(key: key);

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  List<Team> teams = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController appealController = TextEditingController();
  final TextEditingController doctornameController = TextEditingController();
  final TextEditingController AnalysisIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTeams();
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    nameController.dispose();
    surnameController.dispose();
    appealController.dispose();
    doctornameController.dispose();
    AnalysisIdController.dispose();
    super.dispose();
  }

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
        });
        print('Teams loaded: ${teams.length}'); // Debug: Print number of teams loaded
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> addTeam(Team team) async {
    try {
      var response = await http.post(
        Uri.https('localhost:7000', '/api/Patient'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(team.toJson()),
      );

      if (response.statusCode == 201) {
        print('Team added successfully');
        getTeams();
      } else {
        print('Failed to add team. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
  void _clearTextFields() {
    nameController.clear();
    surnameController.clear();
    appealController.clear();
    doctornameController.clear();
    AnalysisIdController.clear();
  }

  void _showAddTeamDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yeni Xəstə Əlavə Et'),
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
                controller: appealController,
                decoration: InputDecoration(labelText: 'Şikayəti'),
              ),
              TextField(
                controller: doctornameController,
                decoration: InputDecoration(labelText: 'Həkim adı'),
              ),
              TextField(
                controller: AnalysisIdController,
                decoration: InputDecoration(labelText: 'Analiz '),
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
                  PatientName: nameController.text,
                  PatientSurname: surnameController.text,
                  PatientAppeal: appealController.text,
                  PatientId: null, // This will be assigned by the server
                  AnalysisId: int.tryParse(AnalysisIdController.text) ?? 0,
                  PatientDoctor: doctornameController.text,
                );
                addTeam(newTeam);
                _clearTextFields();
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
      body: teams.isNotEmpty
          ? ListView.builder(
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
                title: Text(teams[index].PatientName + ' ' + teams[index].PatientSurname),
                subtitle: Text(
                    "Xəstə Şikayəti : " +
                        teams[index].PatientAppeal.toString() +
                        "  Həkim :  " +
                        teams[index].PatientDoctor! +
                        "  Analiz :  " +
                        teams[index].AnalysisId.toString()),
              ),
            ),
          );
        },
      )
          : Center(
        child: Text('Heç bir Xəstə yoxdur'),
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
