

import 'package:flair_app/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/auditorium.dart';

class AuditoriumList extends StatefulWidget {

  late List<Auditorium> auditoriumList;
  final String? boothName;

  AuditoriumList({Key? key, required this.auditoriumList, this.boothName}) : super(key: key);

  @override
  _AuditoriumListState createState() => _AuditoriumListState();
}

class _AuditoriumListState extends State<AuditoriumList> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromRGBO(87, 144, 223, 1),
       appBar: AppBar(
        title: const Text("Auditorium"),
      ),
      body: Center(child: ListView.builder(
          itemCount: widget.auditoriumList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  /*_launchInBrowser(auditoriumList?[index].link);*/
                },
                child: Column(
                  children: [
                    /*Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("${auditoriumList?[index].title}"),
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
                                      "${widget.auditoriumList[index].title}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 100, left: 10, right: 10),
                                  child: Center(
                                    child: Text(
                                      "Timing:- ${DateFormat('yyyy-MM-dd – kk:mm').format(widget.auditoriumList[index].startDatetime)}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                        onPressed: () => _launchInBrowser(
                                            widget.auditoriumList?[index].link),
                                        child: const Text("Open"))),
                              ]),
                        )
                      /*Card(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset('assets/images/auditoriumbg.png')),
                    ),*/
                    )
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
}