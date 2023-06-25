import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, dynamic>> usersData = [];

  Future getUsers() async {
    var response =
        await http.get(Uri.http('api.escuelajs.co', '/api/v1/users'));
    var data = json.decode(response.body);
    setState(() {
      usersData = List<Map<String, dynamic>>.from(data);
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Usuarios',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink, // Cambio de color a morado
      ),
      body: DataTable(
        columns: [
          DataColumn(
            label: Text(
              'Nombre',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Correo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Avatar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: usersData.map((userData) {
          return DataRow(
            cells: [
              DataCell(
                Text(userData['name']),
              ),
              DataCell(
                Text(userData['email']),
              ),
              DataCell(
                CircleAvatar(
                  backgroundImage: NetworkImage(userData['avatar']),
                  radius: 20, // Ajusta el tamaño del círculo del avatar según tus necesidades
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
