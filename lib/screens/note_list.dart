import 'package:flutter/material.dart';
import 'package:notekeeper_app_using_sqlite/models/note.dart';
import 'package:notekeeper_app_using_sqlite/screens/note_detail.dart';
import 'package:notekeeper_app_using_sqlite/utils/database_helper.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  DBHelper? dbHelper;

  late Future<List<NotesModel>> notesList ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData () async {
    notesList = dbHelper!.getNotesList();
  }

  //int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: notesList,
                builder: (context, AsyncSnapshot<List<NotesModel>> snapshot){

                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        reverse: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          return InkWell(
                            onTap: (){
                              dbHelper!.update(
                                NotesModel(
                                  id: snapshot.data![index].id!,
                                    title: 'First flutter note',
                                    age: 18,
                                    email: 'a@gmail.com',
                                    description: 'Let me talk to you tomorrow'
                                )
                              );
                              setState(() {
                                notesList = dbHelper!.getNotesList();
                              });
                            },
                            child: Dismissible(
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                child: Icon(Icons.delete_forever),
                              ),
                              onDismissed: (DismissDirection direction) {
                                setState(() {
                                  dbHelper!.delete(snapshot.data![index].id!);
                                  notesList = dbHelper!.getNotesList();
                                  snapshot.data!.remove(snapshot.data![index]);
                                });
                              },
                              key: ValueKey<int>(snapshot.data![index].id!),
                              child: Card(
                                child: ListTile(
                                  //contentPadding: const EdgeInsets.all(0),
                                  title: Text(snapshot.data![index].title.toString()),
                                  subtitle: Text(snapshot.data![index].description.toString()),
                                  trailing: Text(snapshot.data![index].age.toString()),
                                ),
                              ),
                            ),
                          );
                        });
                  } else{
                    return CircularProgressIndicator();
                  }

            
                }
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //debugPrint('FAB Clicked');
          dbHelper!.insert(
              NotesModel(
                  title: 'Second Note',
                  age: 22,
                  email: 'xyz@gmail.com',
                  description: 'This is my first SQLite app'))
              .then((value) {
            return //print('data added');
            setState(() {
              notesList = dbHelper!.getNotesList();
            });

          }).onError((error, stackTrace) {
            print(error.toString());
          });
          //navigateToDetail('Add Note');
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }



  void navigateToDetail(String title) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return NoteDetail(title);
      },
    ));
  }
}
