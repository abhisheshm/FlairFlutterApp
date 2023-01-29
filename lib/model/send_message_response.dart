// To parse this JSON data, do
//
//     final sendMessageResponse = sendMessageResponseFromJson(jsonString);

import 'dart:convert';

SendMessageResponse sendMessageResponseFromJson(String str) => SendMessageResponse.fromJson(json.decode(str));

String sendMessageResponseToJson(SendMessageResponse data) => json.encode(data.toJson());

class SendMessageResponse {
    SendMessageResponse({
        required this.status,
        required this.message,
        required this.response,
    });

    int status;
    String message;
    Response response;

    factory SendMessageResponse.fromJson(Map<String, dynamic> json) => SendMessageResponse(
        status: json["status"],
        message: json["Message"],
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "response": response.toJson(),
    };
}

class Response {
    Response({
        required this.chatId,
        required this.message,
        required this.chatRoomId,
        required this.userId,
        required this.fileName,
        required this.isFile,
        required this.createdAt,
        required this.fromUser,
    });

    String chatId;
    String message;
    String chatRoomId;
    String userId;
    String fileName;
    String isFile;
    DateTime createdAt;
    String fromUser;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        chatId: json["chat_id"],
        message: json["message"],
        chatRoomId: json["chat_room_id"],
        userId: json["user_id"],
        fileName: json["file_name"],
        isFile: json["is_file"],
        createdAt: DateTime.parse(json["created_at"]),
        fromUser: json["from_user"],
    );

    Map<String, dynamic> toJson() => {
        "chat_id": chatId,
        "message": message,
        "chat_room_id": chatRoomId,
        "user_id": userId,
        "file_name": fileName,
        "is_file": isFile,
        "created_at": createdAt.toIso8601String(),
        "from_user": fromUser,
    };
}
