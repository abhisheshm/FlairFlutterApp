// To parse this JSON data, do
//
//     final roomData = roomDataFromJson(jsonString);

import 'dart:convert';

RoomData roomDataFromJson(String str) => RoomData.fromJson(json.decode(str));

String roomDataToJson(RoomData data) => json.encode(data.toJson());

class RoomData {
    RoomData({
        required this.status,
        required this.message,
        required this.chatRoomData,
        required this.chats,
    });

    int status;
    String message;
    ChatRoomData chatRoomData;
    List<Chat> chats;

    factory RoomData.fromJson(Map<String, dynamic> json) => RoomData(
        status: json["status"],
        message: json["Message"],
        chatRoomData: ChatRoomData.fromJson(json["chat_room_data"]),
        chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "chat_room_data": chatRoomData.toJson(),
        "chats": List<dynamic>.from(chats.map((x) => x.toJson())),
    };
}

class ChatRoomData {
    ChatRoomData({
        required this.chatRoomId,
        required this.roomName,
        required this.isGroup,
        required this.createdAt,
        required this.isOpenGroup,
        required this.markText,
        required this.fairId,
        required this.meetingId,
        required this.boothDetailsId,
    });

    String chatRoomId;
    String roomName;
    String isGroup;
    DateTime createdAt;
    String isOpenGroup;
    String markText;
    String fairId;
    String meetingId;
    String boothDetailsId;

    factory ChatRoomData.fromJson(Map<String, dynamic> json) => ChatRoomData(
        chatRoomId: json["chat_room_id"],
        roomName: json["room_name"],
        isGroup: json["is_group"],
        createdAt: DateTime.parse(json["created_at"]),
        isOpenGroup: json["is_open_group"],
        markText: json["mark_text"],
        fairId: json["fair_id"],
        meetingId: json["meeting_id"],
        boothDetailsId: json["booth_details_id"],
    );

    Map<String, dynamic> toJson() => {
        "chat_room_id": chatRoomId,
        "room_name": roomName,
        "is_group": isGroup,
        "created_at": createdAt.toIso8601String(),
        "is_open_group": isOpenGroup,
        "mark_text": markText,
        "fair_id": fairId,
        "meeting_id": meetingId,
        "booth_details_id": boothDetailsId,
    };
}

class Chat {
    Chat({
        required this.chatId,
        required this.message,
        required this.chatRoomId,
        required this.userId,
        required this.fileName,
        required this.isFile,
        required this.createdAt,
        required this.name,
    });

    String chatId;
    String message;
    String chatRoomId;
    String userId;
    String fileName;
    String isFile;
    DateTime createdAt;
    String name;

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        chatId: json["chat_id"],
        message: json["message"],
        chatRoomId: json["chat_room_id"],
        userId: json["user_id"],
        fileName: json["file_name"],
        isFile: json["is_file"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "chat_id": chatId,
        "message": message,
        "chat_room_id": chatRoomId,
        "user_id": userId,
        "file_name": fileName,
        "is_file": isFile,
        "created_at": createdAt.toIso8601String(),
        "name": name,
    };
}
