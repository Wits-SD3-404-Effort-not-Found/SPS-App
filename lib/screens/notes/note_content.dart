class NoteContent {
  int noteID = 0;
  String title = "";
  String body = "";

  NoteContent();

  void setNoteID(int noteID) {
    this.noteID = noteID;
  }

  int getNoteID() {
    return noteID;
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setBody(String body) {
    this.body = body;
  }

  String getTitle() {
    return title;
  }

  String getBody() {
    return body;
  }
}
