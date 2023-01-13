import 'package:flair_app/model/auditorium.dart';
import 'package:flair_app/model/resource.dart';
import 'package:flair_app/model/video_vault.dart';
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
