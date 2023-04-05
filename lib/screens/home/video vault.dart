

import 'package:flair_app/model/booth_list.dart';
import 'package:flair_app/screens/home/upper_tab_bar.dart';
import 'package:flair_app/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/auditorium.dart';
import '../../model/video_vault.dart';

class VideoList extends StatefulWidget {

  late List<VideoVault>? videoVaultList;
  final String? boothName;

  VideoList({Key? key, required this.videoVaultList, this.boothName}) : super(key: key);

  @override
  _AuditoriumListState createState() => _AuditoriumListState();
}

class _AuditoriumListState extends State<VideoList> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromRGBO(87, 144, 223, 1),
      appBar: AppBar(
        title: const Text("Video Vault"),
      ),
      body: Center(
          child: ListView.builder(
              itemCount: widget.videoVaultList?.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        /* Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("${videoVaultList?[index].linkText}"),
                    ),*/

                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  Image(
                                    image: new AssetImage(
                                        'assets/images/auditoriumbg.png'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 120, left: 10, right: 10),
                                    child: Center(
                                      child: Text(
                                        "${widget.videoVaultList?[index].linkText}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: RaisedButton(
                                          onPressed: () => _launchInBrowser(
                                              widget.videoVaultList?[index].linkContnent),
                                          child: const Text("Play Now"))),
                                ]),
                          ),
                        )
                        /*Card(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset('assets/images/card_bg.png')),
                    ),*/
                      ],
                    ),
                  ),
                );
              })),
    );
  }
  Future<void> _launchInBrowser(String? url) async {
    print("lllllllll ${url}");
    final uri = Uri.parse(url!);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  String cityImage(String? city) {
    if (city!.contains("Slovakia")) {
      return "assets/images/city1.jpeg";
    } else if (city!.contains("Lithuania")) {
      return "assets/images/city2.jpeg";
    } else if (city!.contains("Italy")) {
      return "assets/images/city3.jpeg";
    } else if (city!.contains("Slovenia")) {
      return "assets/images/city4.jpeg";
    } else if (city!.contains("Hungary")) {
      return "assets/images/city5.jpeg";
    } else if (city!.contains("Belgium")) {
      return "assets/images/city7.jpeg";
    } else if (city!.contains("Europe")) {
      return "assets/images/city6.jpeg";
    }

    return "assets/images/city1.jpeg";
  }

}