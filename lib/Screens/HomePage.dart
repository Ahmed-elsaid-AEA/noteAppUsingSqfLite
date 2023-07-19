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

  Future<List<Map>> readData() async {
    List<Map> response = await db.selectData('select * from $kTableNotes');
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(kAddNote);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: Icon(Icons.note),
        title: Row(
          children: [Text('Note App')],
        ),
      ),
      body: Container(
        child: ListView(children: [
          FutureBuilder(
            future: readData(),
            builder: (context, AsyncSnapshot<List<Map>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title:
                            Text(snapshot.data![index]['$kTitleNoteCoulumn']),
                        subtitle:
                            Text(snapshot.data![index]['$kTextNoteCoulumn']),
                        trailing: IconButton(
                            onPressed: () async {
                              int delted = await db.deleteData(
                                  'delete from $kTableNotes where $kIdNoteCoulumn=${snapshot.data![index]['$kIdNoteCoulumn']}');
                              if (delted > 0) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                    (route) => false);
                              }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                    );
                  },
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ]),
      ),
    );
  }
}
