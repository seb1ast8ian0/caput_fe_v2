import 'package:Caput/domain/entities/neuron/payloads/note.dart';
abstract class NoteRepository {

  Future<void> addNote(String neuronId, Note note);
  Future<void> deleteNote(String neuronId);
  Future<void> updateNote(String neuronId, Note note);
  Future<Note> getNote(String neuronId);

}