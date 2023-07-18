import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app_using_sqflite/MydataBasePackage/MyDb.dart';
import 'package:note_app_using_sqflite/Screens/HomePage.dart';
import 'package:note_app_using_sqflite/helpers/Constants.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> formState = GlobalKey();
  MyDb db = MyDb();

  @override
  Widget build(BuildContext context) {
    TextEditingController note = TextEditingController();
    TextEditingController title = TextEditingController();
    TextEditingController color = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Container(
        child: ListView(
          children: [
            Form(
                key: formState,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: title,
                        decoration: InputDecoration(hintText: 'title'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'note'),
                        controller: note,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'color'),
                        controller: color,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          int insertd = await db.insertData('''
                          INSERT INTO $kTableNotes ($kTitleNoteCoulumn , $kTextNoteCoulumn, $kColorNoteCoulumn )
                          VALUES ('${title.text}','${note.text}','${color.text}')
                          ''');
                          if (insertd > 0) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                (route) => false);
                          }
                        },
                        child: Text(
                          'add note',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
