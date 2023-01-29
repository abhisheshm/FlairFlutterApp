
import 'package:flair_app/model/auditorium.dart';
import 'package:flair_app/model/chat_users.dart';
import 'package:flair_app/model/resource.dart';
import 'package:flair_app/model/room_data.dart';
import 'package:flair_app/model/send_message_response.dart';
import 'package:flair_app/model/video_vault.dart';
import 'package:flair_app/model/login_response.dart';
import 'package:http/http.dart' as http;

import '../model/booth_details.dart';
import '../model/booth_list.dart';

class Client {
  Future<List<Auditorium>?> getAuditorium() async {
    var client = http.Client();

    var uri = Uri.parse(
        "https://e-scheduler.com/hef/api_fair/Fair/get_auditorium_details");
    var response = await client.post(uri, headers: {
      'X-Requested-With': 'XMLHttpRequest',
    }, body: {
      'fair_id': "1",
    });
    print(response.request);
    print(response.body);
    if (response.statusCode == 200) {
      var json = response.body;
      return auditoriumFromJson(json);
    }
    return null;
  }
  Future<List<VideoVault>?> getVideoVault() async {
    var client = http.Client();

    var uri = Uri.parse(
        "https://e-scheduler.com/hef/api_fair/Fair/get_video_details");
    var response = await client.post(uri, headers: {
      'X-Requested-With': 'XMLHttpRequest',
    }, body: {
      'fair_id': "1",
    });
    print(response.request);
    print(response.body);
    if (response.statusCode == 200) {
      var json = response.body;
      return videoVaultFromJson(json);
    }
    return null;
  }
  Future<List<ResourceDetails>?> getResource() async {
    var client = http.Client();

    var uri = Uri.parse(
        "https://e-scheduler.com/hef/api_fair/Fair/get_resource_details");
    var response = await client.post(uri, headers: {
      'X-Requested-With': 'XMLHttpRequest',
    }, body: {
      'fair_id': "1",
    });
    print(response.request);
    print(response.body);
    if (response.statusCode == 200) {
      var json = response.body;
      return resourceDetailsFromJson(json);
    }
    return null;
  }
  Future<UserDetail?> loginAsync(String email) async {
    var client = http.Client();

    var uri = Uri.parse(
        "https://e-scheduler.com/hef/api_fair/Fair/login");
    var response = await client.post(uri, headers: {
      'X-Requested-With': 'XMLHttpRequest',
    }, body: {
      'email': email,
    });
    if (response.statusCode == 200) {
      var json = response.body;
      return userDetailFromJson(json);
    }
    return null;
  }
  Future<List<ChatUserResponse>> getChatUsers() async {
    var client = http.Client();

    var uri = Uri.parse(
        "https://e-scheduler.com/hef/api_fair/Fair/get_chat_groups");
    var response = await client.post(uri, headers: {
      'X-Requested-With': 'XMLHttpRequest',
    }, body: {
      'fair_id': "1",
    });
    print(response.request);
    print(response.body);
    if (response.statusCode == 200) {
      var json = response.body;
      return chatUsersFromJson(json).response;
    }
    return [];
  }
  Future<RoomData?> getMessagesByChatId(String roomId) async {
    var client = http.Client();

    var uri = Uri.parse(
        "https://e-scheduler.com/hef/api_fair/Fair/init_group_chat");
    var response = await client.post(uri, headers: {
      'X-Requested-With': 'XMLHttpRequest',
    }, body: {
      'chat_room_id': roomId,
    });
    if (response.statusCode == 200) {
      var json = response.body;
      return roomDataFromJson(json);
    }
    return null;
  }
  Future<SendMessageResponse?> uploadTextMessage(String message, String chat_room_id, String user_id) async {
    var client = http.Client();

    var uri = Uri.parse(
        "https://e-scheduler.com/hef/api_fair/Fair/send_message");
    var response = await client.post(uri, headers: {
      'X-Requested-With': 'XMLHttpRequest',
    }, body: {
      'message':message,
      'chat_room_id':chat_room_id,
      'user_id':user_id
    });
    if (response.statusCode == 200) {
      var json = response.body;
      return sendMessageResponseFromJson(json);
    }
    return null;
  }
  Future<SendMessageResponse?> uploadFile(String file_path, String chat_room_id, String user_id) async {
    var headers = {
      'X-Requested-With': 'XMLHttpRequest'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://e-scheduler.com/hef/api_fair/Fair/send_message'));
    request.fields.addAll({
      'message': '',
      'chat_room_id': chat_room_id,
      'user_id': user_id
    });
    request.files.add(await http.MultipartFile.fromPath('file', file_path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      return sendMessageResponseFromJson(json);
    }
    return null;
  }

  Future<List<BoothList>?> getBoothList() async {
    var client = http.Client();

    var uri =
        Uri.parse("https://e-scheduler.com/hef/api_fair/Fair/get_booth_list");
    var response = await client.post(uri, headers: {
      'X-Requested-With': 'XMLHttpRequest',
    }, body: {
      'fair_id': "1",
    });
    print(response.request);
    print(response.body);
    if (response.statusCode == 200) {
      var json = response.body;
      return boothListFromJson(json);
    }
    return null;
  }

  Future<List<ResourceDetails>?> getNetworking() async {
    var client = http.Client();

    var uri = Uri.parse(
        "https://e-scheduler.com/hef/api_fair/Fair/get_network_details");
    var response = await client.post(uri, headers: {
      'X-Requested-With': 'XMLHttpRequest',
    }, body: {
      'fair_id': "1",
    });
    print(response.request);
    print(response.body);
    if (response.statusCode == 200) {
      var json = response.body;
      return resourceDetailsFromJson(json);
    }
    return null;
  }

  Future<BoothDetails?> getBoothDetails(String boothId) async {
    var client = http.Client();

    var uri = Uri.parse(
        "https://e-scheduler.com/hef/api_fair/Fair/get_booth_details");
    var response = await client.post(uri, headers: {
      'X-Requested-With': 'XMLHttpRequest',
    }, body: {
      'fair_id': "1",
      'booth_id': boothId,
    });
    print(response.request);
    print(response.body);
    if (response.statusCode == 200) {
      var json = response.body;
      return boothDetailsFromJson(json);
    }
    return null;
  }
}
