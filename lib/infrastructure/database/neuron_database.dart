import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'neuron_database.g.dart';


@DriftDatabase(tables: [
  Neurons, 
  Tags, 
  NeuronTagRelations, 
  Payloads,
  Tasks,
  Notes,
  Dates
])
class CaputDatabase extends _$CaputDatabase {
  CaputDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DataClassName('NeuronDBO')
class Neurons extends Table {

  TextColumn get neuronId => text()();
  TextColumn get userId => text()();
  DateTimeColumn get creationTs => dateTime()();
  DateTimeColumn get updateTs => dateTime()();

  @override
  Set<Column> get primaryKey => {neuronId};

}

@DataClassName('TagDBO')
class Tags extends Table {

  TextColumn get tagId => text()();
  TextColumn get userId => text()();
  TextColumn get caption => text()();
  TextColumn get body => text()();
  DateTimeColumn get creationTs => dateTime()();
  DateTimeColumn get updateTs => dateTime()();

  @override
  Set<Column> get primaryKey => {tagId};

}

@DataClassName('PayloadDBO')
class Payloads extends Table {

  TextColumn get neuronId => text()();
  TextColumn get type => text()();
  TextColumn get caption => text()();
  IntColumn get priority => integer()();

  @override
  Set<Column> get primaryKey => {neuronId};

}

@DataClassName('DateDBO')
class Dates extends Table {

  TextColumn get neuronId => text()();
  DateTimeColumn get dateTs => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {neuronId};

}

@DataClassName('TaskDBO')
class Tasks extends Table {

  TextColumn get neuronId => text()();
  BoolColumn get completed => boolean()();
  DateTimeColumn get dateTs => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {neuronId};

}

@DataClassName('NoteDBO')
class Notes extends Table {

  TextColumn get neuronId => text()();

  @override
  Set<Column> get primaryKey => {neuronId};

}

class NeuronTagRelations extends Table {

  TextColumn get neuronId => text()();
  TextColumn get tagId => text()();

}