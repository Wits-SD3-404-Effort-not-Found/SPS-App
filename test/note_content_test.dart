import 'package:flutter_test/flutter_test.dart';
import 'package:sps_app/screens/notes/note_content.dart';

void main() {
  final testNoteContent = NoteContent();

  // tests for getIsNewNote() and setIsNewNote()
  test(" true test setter and getter for isNewNote", () {
    testNoteContent.setIsNewNote(true);
    expect(testNoteContent.getIsNewNote(), true);
  });
  test(" false test setter and getter for isNewNote", () {
    testNoteContent.setIsNewNote(false);
    expect(testNoteContent.getIsNewNote(), false);
  });

  // test for getNoteID() and setNoteID()
  test("test getter and setter for NoteID", () {
    testNoteContent.setNoteID(5);
    expect(testNoteContent.getNoteID(), 5);
  });

  // test for setTitle() and getTitle()
  test("test getter and setter for title", () {
    testNoteContent.setTitle("test title");
    expect(testNoteContent.getTitle(), "test title");
  });

  test("empty string test getter and setter for title", () {
    testNoteContent.setTitle("");
    expect(testNoteContent.getTitle(), "");
  });

  // test for setBody() and getBody()
  test("test getter and setter for body", () {
    testNoteContent.setBody("test body");
    expect(testNoteContent.getBody(), "test body");
  });

  test("empty string test getter and setter for body", () {
    testNoteContent.setBody("");
    expect(testNoteContent.getBody(), "");
  });
}
