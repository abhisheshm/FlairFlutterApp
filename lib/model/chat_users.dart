// To parse this JSON data, do
//
//     final chatUsers = chatUsersFromJson(jsonString);

import 'dart:convert';

ChatUsers chatUsersFromJson(String str) => ChatUsers.fromJson(json.decode(str));

String chatUsersToJson(ChatUsers data) => json.encode(data.toJson());

class ChatUsers {
    ChatUsers({
        required this.status,
        required this.message,
        required this.response,
    });

    int status;
    String message;
    List<ChatUserResponse> response;

    factory ChatUsers.fromJson(Map<String, dynamic> json) => ChatUsers(
        status: json["status"],
        message: json["Message"],
        response: List<ChatUserResponse>.from(json["response"].map((x) => ChatUserResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
    };
}

class ChatUserResponse {
    ChatUserResponse({
        required this.chatRoomId,
        required this.roomName,
        required this.isGroup,
        required this.createdAt,
        required this.isOpenGroup,
        required this.markText,
        required this.fairId,
        required this.meetingId,
        required this.boothDetailsId,
        required this.groupImage,
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
    String groupImage;

    factory ChatUserResponse.fromJson(Map<String, dynamic> json) => ChatUserResponse(
        chatRoomId: json["chat_room_id"],
        roomName: json["room_name"],
        isGroup: json["is_group"],
        createdAt: DateTime.parse(json["created_at"]),
        isOpenGroup: json["is_open_group"],
        markText: json["mark_text"],
        fairId: json["fair_id"],
        meetingId: json["meeting_id"],
        boothDetailsId: json["booth_details_id"],
        groupImage: json["group_image"],
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
        "group_image": groupImage,
    };
}
