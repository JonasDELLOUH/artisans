class MessageModel {
  final String id;
  final String content;
  final String idFrom;
  final String idTo;
  final int timestamp;
  final bool isImage; // Ajoutez un champ pour indiquer si c'est une image

  MessageModel({
    required this.id,
    required this.content,
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.isImage,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json){
    return MessageModel(
        id: json["id"], content: json["content"], idFrom: json["idFrom"], idTo: json["idTo"], timestamp: json["timestamp"], isImage: json["isImage"]);
  }
}
