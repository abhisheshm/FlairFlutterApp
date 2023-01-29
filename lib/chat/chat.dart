import 'package:flair_app/chat/chat_list.dart';
import 'package:flair_app/model/chat_users.dart';
//import 'package:flair_app/model/chat_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../network/client.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<ChatUserResponse> chatUsersList = [];
  TextEditingController search_controller = new TextEditingController();

  var isLoadedChatUser = false;

  getChatUserData() async {
    chatUsersList = await Client().getChatUsers();
    if (chatUsersList != null) {
      setState(() {
        isLoadedChatUser = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getChatUserData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: TextField(
            controller: search_controller,
            onChanged: (value) {
              setState(() {
                
              });
            },
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.grey.shade600),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey.shade600,
                size: 20,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.only(top: 15, left: 8, right: 8),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey.shade100)),
            ),
          ),
        ),
        Visibility(
          visible: isLoadedChatUser,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            padding: EdgeInsets.only(top: 16),
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: chatUsersList.length,
            itemBuilder: (context, index) {
              String roomName = chatUsersList[index].roomName.toLowerCase();
              if(search_controller.text.isNotEmpty && !roomName.contains(search_controller.text.toLowerCase())){
                return Container();
              }
              return ChatList(
                  roomId: chatUsersList[index].chatRoomId,
                  name: chatUsersList[index].roomName,
                  imageUrl: chatUsersList[index].groupImage,
                );
            },
          ),
        )
      ],
    );
  }
}
