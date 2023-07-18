import 'package:flutter/material.dart';
import 'package:note_app_using_sqflite/MydataBasePackage/MyDb.dart';
import 'package:note_app_using_sqflite/helpers/Constants.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyDb db = MyDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.note),
        title: Row(
          children: [Text('Note App')],
        ),
      ),
      body: Column(children: [
        MaterialButton(onPressed: () {
          db.insertData('insert into $kNoteDbName val')
        },)
      ]),
    );
  }
}
