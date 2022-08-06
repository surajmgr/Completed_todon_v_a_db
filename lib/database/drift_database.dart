import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
// import 'package:drift/web.dart';

part 'drift_database.g.dart';

// Table of Row: Note && Column: Defined in the class Note
class Note extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 3, max: 32)();
  TextColumn get description => text().named('description').nullable()();
  DateTimeColumn get date => dateTime().nullable()();
  IntColumn get priority => integer().nullable()();
  IntColumn get color => integer().nullable()();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

// Prepare database table
@DriftDatabase(tables: [Note])
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  //Load All note entries
  Future<List<NoteData>> get getNoteList => select(note).get();

  //Observe all the entries
  Stream<List<NoteData>> get watchNoteList => select(note).watch();

  //Insert
  Future insertNote(NoteCompanion noteCompanion) =>
      into(note).insert(noteCompanion);

  //Update
  Future updateNote(NoteData noteData) => update(note).replace(noteData);

  //Delete
  Future deleteNote(NoteData noteData) => delete(note).delete(noteData);
}

// WebDatabase _openConnection() {
//   return WebDatabase('db');
// }
