

import 'package:flair_app/model/booth_list.dart';
import 'package:flair_app/screens/home/upper_tab_bar.dart';
import 'package:flair_app/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/auditorium.dart';

class ExihbitList extends StatefulWidget {

  late List<BoothList>? boothList;
  final String? boothName;

  ExihbitList({Key? key, required this.boothList, this.boothName}) : super(key: key);

  @override
  _AuditoriumListState createState() => _AuditoriumListState();
}

class _AuditoriumListState extends State<ExihbitList> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromRGBO(87, 144, 223, 1),
      appBar: AppBar(
        title: const Text("Exhibition Hall"),
      ),
      body: Center(
          child: ListView.builder(
              itemCount: widget.boothList?.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 350,
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                  child: InkWell(
                    onTap: () {
                      /*Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => UpperTabBar())));*/
                    },
                    child: Column(
                      children: [
                        /*Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("${auditoriumList?[index].title}"),
                    ),*/

                        Card(
                            child: Padding(
                              padding: EdgeInsets.all(1),
                              child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    Image.asset(
                                      cityImage(widget.boothList?[index].boothName),
                                      fit: BoxFit.fill,
                                      height: 280,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 285, left: 10, right: 10),
                                      child: Center(
                                        child: Text(
                                          "${widget.boothList?[index].boothName}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: RaisedButton(
                                            onPressed: () => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                builder: ((context) => UpperTabBar(
                                                  boothName: widget.boothList?[index]
                                                      .boothName,
                                                  boothId:
                                                  widget.boothList?[index].boothId,
                                                )))),
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