import 'dart:io';

import 'package:flair_app/model/room_data.dart';
import 'package:flair_app/model/send_message_response.dart';
import 'package:flair_app/network/client.dart';
import 'package:flair_app/storage/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  String senderName;
  bool isFile;
  ChatMessage(
      {required this.messageContent,
      required this.messageType,
      required this.senderName,
      required this.isFile});
}

class ChatDetailPage extends StatefulWidget {
  String roomId;
  String url;
  ChatDetailPage({required this.roomId, required this.url});
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  TextEditingController text_controller = new TextEditingController();

  RoomData? roomData;
  List<ChatMessage> messages = [];
  String chat_id = "";

  var isChatLoaded = true;

  getRoomData() async {
    roomData = await Client().getMessagesByChatId(widget.roomId);
    chat_id = (await getUserId()) ?? "33";
    if (chat_id.isEmpty) {
      chat_id = "33";
    }
    if (roomData != null) {
      roomData?.chats.forEach((chat) => {
            // ignore: unnecessary_new
            messages.add(
              new ChatMessage(
                  messageContent:
                      chat.isFile == "1" ? chat.fileName : chat.message,
                  messageType: (chat.userId == chat_id) ? "sender" : "receiver",
                  isFile: (chat.isFile == "1") && false,
                  senderName: chat.name),
            )
          });
      setState(() {
        isChatLoaded = true;
      });
    }
  }

  customAlert(String title, String alertMessage) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(alertMessage),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(true);
          },
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getRoomData();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isChatLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            flexibleSpace: SafeArea(
              child: Container(
                padding: EdgeInsets.only(right: 16),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.url),
                      maxRadius: 20,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            roomData?.chatRoomData.roomName ?? "",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                  physics: ScrollPhysics(),
                  reverse: true,
                  child: ListView.builder(
                    itemCount: messages.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 100),
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (messages[index].messageType == "receiver"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messages[index].messageType == "receiver"
                                  ? Colors.grey.shade200
                                  : Colors.blue[200]),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (messages[index].messageType == "receiver")
                                    Text(
                                      messages[index].senderName,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  if (!messages[index].isFile)
                                    Linkify(
                                      onOpen: (link) async {
                                        Uri url = Uri.parse(link.url);
                                        bool canLaunch =
                                            await canLaunchUrl(url);
                                        if (canLaunch) {
                                          await launchUrl(url,
                                              mode: LaunchMode
                                                  .externalApplication);
                                        }
                                      },
                                      text: messages[index].messageContent,
                                      style: TextStyle(fontSize: 15),
                                      linkStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.lightBlue),
                                    )
                                  else
                                    InkWell(
                                        onTap: () async {
                                          // _permissionReady = await _checkPermission();
                                          // if (_permissionReady) {
                                          //   await _prepareSaveDir();
                                          //   try {
                                          //     await Dio().download("https://******/image.jpg",
                                          //         _localPath + "/" + "filename.jpg");
                                          //     print("Download Completed.");
                                          //   } catch (e) {
                                          //     print("Download Failed.\n\n" + e.toString());
                                          //   }
                                          // }
                                        },
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(top: 8),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey
                                                        .withOpacity(0.5)),
                                                padding: EdgeInsets.all(8),
                                                child: Icon(Icons.file_open,
                                                    color: Colors.black),
                                              )
                                            ]))
                                ]),
                          ),
                        ),
                      );
                    },
                  )),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (result != null) {
                            File file = File(result.files.single.path ?? "");
                            setState(() {
                              isChatLoaded:
                              false;
                            });
                            SendMessageResponse? res = await Client().uploadFile(file.path, roomData?.chatRoomData.chatRoomId ?? "", chat_id);
                            if (res?.response.isFile == "1") {
                              //customAlert("Success", "Message Sent Successfully");
                              await getRoomData();
                            } else {
                              customAlert(
                                  "Error", "Some error occured while Uploading");
                            }
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: text_controller,
                          decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          if (text_controller.text.isEmpty) {
                            customAlert("Error", "Empty Message Box");
                          } else {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              isChatLoaded:
                              false;
                            });
                            SendMessageResponse? res = await Client()
                                .uploadTextMessage(
                                    text_controller.text,
                                    roomData?.chatRoomData.chatRoomId ?? "",
                                    chat_id);
                            if (res?.response.message == text_controller.text) {
                              //customAlert("Success", "Message Sent Successfully");
                              text_controller.clear();
                              await getRoomData();
                            } else {
                              customAlert(
                                  "Error", "Some error occured while posting");
                            }
                          }
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                        backgroundColor: Colors.blue,
                        elevation: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
