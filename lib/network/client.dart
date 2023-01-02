
import 'package:flair_app/model/auditorium.dart';
import 'package:flair_app/model/resource.dart';
import 'package:flair_app/model/video_vault.dart';
import 'package:flair_app/model/login_response.dart';
import 'package:http/http.dart' as http;

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
}
