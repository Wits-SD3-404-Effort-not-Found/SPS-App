class NoteContent {
  String title = "";
  String body = "";
  //String createdAt= "g";
  //String modifiedAt="";

  NoteContent();

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

  /*TaskOpj.fromJson(Map<String, dynamic> json) {
    guid = json['guid'];
    note = json['note'];
    createdAt = json['createdAt'];
    modfiledAt = json['modfiledAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guid'] = this.guid;
    data['note'] = this.note;
    data['createdAt'] = this.createdAt;
    data['modfiledAt'] = this.modfiledAt;
    return data;
  }*/
}
