import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NursesPage extends StatefulWidget {
  NursesPage({Key? key}) : super(key: key);

  @override
  State<NursesPage> createState() => _NursesPageState();
}

class _NursesPageState extends State<NursesPage> {
  List<Team> teams = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();


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
    super.dispose();
  }

  Future<void> getTeams() async {
    try {
      var response = await http.get(Uri.https('localhost:7000', '/api/Nurses'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print('Response data: $jsonData'); // Debug: Print response data

        List<Team> loadedTeams = [];
        for (var eachTeam in jsonData) {
          final team = Team(
            NurseName: eachTeam['nurseName'],
            NurseSurname: eachTeam['nurseSurname'],
            NurseId: int.tryParse(eachTeam['nurseId'].toString()) ?? 0,
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
        Uri.https('localhost:7000', '/api/Nurses'),
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
  }

  void _showAddTeamDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yeni Tib bacısı Əlavə Et'),
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
                  NurseName: nameController.text,
                  NurseSurname: surnameController.text,
                  NurseId: null, // This will be assigned by the server

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
                title: Text(teams[index].NurseName ),
                subtitle: Text(
                        teams[index].NurseSurname),
              ),
            ),
          );
        },
      )
          : Center(
        child: Text('Heç bir Tibb Bacısı yoxdur'),
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
  final String NurseName;
  final String NurseSurname;
  final int? NurseId; // optional, nullable


  Team({
    required this.NurseName,
    required this.NurseSurname,
    this.NurseId, // optional

  });

  Map<String, dynamic> toJson() {
    return {
      'nurseName': NurseName,
      'nurseSurname': NurseSurname,
    };
  }
}
