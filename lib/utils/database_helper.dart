import 'dart:io';
import 'package:intl/date_symbol_data_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/note.dart';

class DBHelper {
  //static DBHelper? _DBHelper; // Singleton Database
  static Database? _db; // Singleton Database

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    // Get the directory path for Android and iOS to store database.
    //io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join('${documentDirectory.path}notes.db');

    // Open/create the database at a given path
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, age INTEGER NOT NULL, description TEXT NOT NULL, email TEXT)',
    );
  }

  // Fetch Operation: Get all note objects from database

  Future<List<NotesModel>> getNotesList() async {
    var dbClient = await db;

    //var result = await db.rawQuery('GET * FROM $noteTable order by $colPriority ASC');
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('notes');
    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }

  // Insert Operation : Insert a Note to database
  Future<NotesModel> insert(NotesModel notesModel) async {
    var dbClient = await db;
    await dbClient!.insert('notes', notesModel.toMap());
    return notesModel;
  }
  // Update Operation: Delete a Note object from database
  Future<int> delete(int id) async {
    var dbClient = await db;

    return await dbClient!.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id]
    );
  }


  // Update values objects in database
  Future<int> update(NotesModel notesModel) async {
    var dbClient = await db;

    return await dbClient!.update(
        'notes',
        notesModel.toMap(),
        where: 'id = ?',
        whereArgs: [notesModel.id],
    );
  }
}
