class ChatModel {
  String? contentName, fileLink, type;
  String? answerKey;
  String? mainQuestion;
  int? sectionId;
  bool? isUser;
  String? id;

  ChatModel(
      {this.isUser,
      this.contentName,
      this.fileLink,
      this.type,
      this.answerKey,
      this.mainQuestion,
      this.sectionId,this.id});

  factory ChatModel.fromJson(Map<String, dynamic> json, String type,String msgId) =>
      ChatModel(
          id: msgId,
          contentName: json["Content_Name"],
          fileLink: json["Supporting_Document_Path"],
          type: type,
          isUser: false,
          answerKey: json["Answer_Key_Path"],
          mainQuestion: json["Main_Question"],
          sectionId: json["Section_ID"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "Content_Name": contentName,
        "Supporting_Document_Path": fileLink,
        "type": type,
        "Main_Question": mainQuestion,
        "Answer_Key_Path": answerKey,
        "Section_ID": sectionId,
      };
}
