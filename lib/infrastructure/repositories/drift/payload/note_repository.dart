import 'package:Caput/domain/entities/neuron/payloads/note.dart';
import 'package:Caput/domain/get_models/database_controller.dart';
import 'package:Caput/domain/repositories/payload/note_repository.dart';
import 'package:Caput/infrastructure/database/neuron_database.dart';
import 'package:get/get.dart';

class NoteRepositoryDrift extends NoteRepository{

  late CaputDatabase database;

  NoteRepositoryDrift(){

    final DatabaseController c = Get.find();
    database = c.database;

  }

  @override
  Future<void> addNote(String neuronId, Note note) async {
    
    await database
      .into(database.notes)
      .insert(
        NoteDBO(
          neuronId: neuronId,
        )
      );

  }

  @override
  Future<void> deleteNote(String neuronId) async {

    final query = database
      .delete(database.notes)
      ..where(
        (tbl) => tbl.neuronId.equals(neuronId)
      );

    await query.go();
      
  }

  @override
  Future<Note> getNote(String neuronId) async {

    final query = database
      .select(database.notes)
      ..where(
        (tbl) => tbl.neuronId.equals(neuronId)
      );

    final result = await query.getSingle();
    
    return Note(
      caption: "",
      priority: 1,
      type: "note"
    );

  }

  @override
  Future<void> updateNote(String neuronId, Note updatedNote) async {
    
    final query = database
      .update(database.notes)
      ..where(
        (tbl) => tbl.neuronId.equals(neuronId)
      );
      
      await query.write(
      NoteDBO(
        neuronId: neuronId
      )
    );

  }

}