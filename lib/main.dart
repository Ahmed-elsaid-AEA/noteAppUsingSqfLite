import 'package:flutter/material.dart';
import 'package:note_app_using_sqflite/Screens/AddNote.dart';
import 'package:note_app_using_sqflite/Screens/HomePage.dart';
import 'package:note_app_using_sqflite/helpers/Constants.dart';

void main() {
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        kHomePage: (context) => HomePage(),
        kAddNote: (context) => AddNote(),
      },
      initialRoute: kHomePage,
    );
  }
}
