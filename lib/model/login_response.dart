// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'dart:convert';

UserDetail userDetailFromJson(String str) => UserDetail.fromJson(json.decode(str));

String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
    UserDetail({
        this.status,
        this.message,
        this.userId,
        this.userEmail,
        this.userName,
    });

    String? status;
    String? message;
    String? userId;
    String? userEmail;
    String? userName;

    factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        status: json["status"],
        message: json["Message"],
        userId: json["UserId"],
        userEmail: json["User Email"],
        userName: json["User Name"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "UserId": userId,
        "User Email": userEmail,
        "User Name": userName,
    };
}
