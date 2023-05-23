class NoteContent {
  int noteID = 0;
  String title = "";
  String body = "";
  bool isNewNote = false;
  bool isPublicNote = false;

  NoteContent();

  void setIsNewNote(bool isNewNote) {
    this.isNewNote = isNewNote;
  }

  bool getIsNewNote() {
    return isNewNote;
  }

  void setIsPublicNote(bool isPublicNote) {
    this.isPublicNote = isPublicNote;
  }

  bool getIsPublicNote() {
    return isPublicNote;
  }

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
