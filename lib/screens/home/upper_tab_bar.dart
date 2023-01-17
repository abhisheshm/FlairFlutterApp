import 'package:flair_app/model/booth_details.dart';
import 'package:flair_app/screens/home/video_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../network/client.dart';
import '../home_page.dart';

class UpperTabBar extends StatefulWidget {
  final String? boothName;
  final int? boothId;

  const UpperTabBar({required this.boothName, this.boothId});

  @override
  _UpperTabBarPageState createState() => _UpperTabBarPageState();
}

class _UpperTabBarPageState extends State<UpperTabBar> {
  late BoothDetails _boothDetails;
  var isLoaded = false;
  var isVideoLoad = false;
  var isAboutLoad = false;
  var isBrochuresLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBoothDetailsData();
  }

  getBoothDetailsData() async {
    print("kkkkk");
    _boothDetails =
        (await Client().getBoothDetails(widget.boothId.toString()))!;
    if (_boothDetails != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.boothName!),
      ),
      body: SingleChildScrollView(
        child: isLoaded
            ? Container(
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,

                  //mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomSlidingSegmentedControl<int>(
                      isStretch: true,
                      initialValue: 1,
                      children: const {
                        1: Text('About'),
                        2: Text('Video'),
                        3: Text('Brochures'),
                      },
                      decoration: BoxDecoration(
                        color: CupertinoColors.lightBackgroundGray,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      thumbDecoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            offset: const Offset(
                              0.0,
                              2.0,
                            ),
                          ),
                        ],
                      ),
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInToLinear,
                      onValueChanged: (v) {
                        if (v == 2) {
                          setState(() {
                            isVideoLoad = true;
                            isAboutLoad = false;
                            isBrochuresLoad = false;
                          });

                          print(v);
                        } else if (v == 3) {
                          setState(() {
                            isAboutLoad = false;
                            isVideoLoad = false;
                            isBrochuresLoad = true;
                          });
                        } else {
                          setState(() {
                            isAboutLoad = true;
                            isVideoLoad = false;
                            isBrochuresLoad = false;
                          });
                        }
                        print(v);
                        print("isVideoLoad$isVideoLoad");
                        print("isAboutLoad$isAboutLoad");
                        print("isBrochuresLoad$isBrochuresLoad");
                      },
                    ),
                    // const SizedBox(height: 16),
                    const SizedBox(height: 20),

                    if (isVideoLoad) ...[
                      Container(
                        height: 500,
                        child: ListView.builder(
                            itemCount: _boothDetails.resource?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      if (_boothDetails
                                              .resource?[index].linkType ==
                                          "3") ...[
                                        Card(
                                          child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Stack(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                children: <Widget>[
                                                  Image(
                                                    image: new AssetImage(
                                                        'assets/images/auditoriumbg.png'),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 120,
                                                            left: 20,
                                                            right: 10),
                                                    child: Center(
                                                      child: Text(
                                                        "${_boothDetails.resource?[index].linkText}",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: RaisedButton(
                                                          onPressed: () =>
                                                              _launchInBrowser(
                                                                  _boothDetails
                                                                      .resource?[
                                                                          index]
                                                                      .linkContnent),
                                                          child: const Text(
                                                              "Play Now"))),
                                                ]),
                                          ),
                                        )
                                      ]
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ] else if (isBrochuresLoad) ...[
                      Container(
                        height: 500,
                        child: ListView.builder(
                            itemCount: _boothDetails.resource?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      if (_boothDetails
                                              .resource?[index].linkType ==
                                          "4") ...[
                                        Card(
                                          child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Stack(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                children: <Widget>[
                                                  Image(
                                                    image: new AssetImage(
                                                        'assets/images/auditoriumbg.png'),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 120,
                                                            left: 20,
                                                            right: 10),
                                                    child: Center(
                                                      child: Text(
                                                        "${_boothDetails.resource?[index].linkText}",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: RaisedButton(
                                                          onPressed: () =>
                                                              _launchInBrowser(
                                                                  _boothDetails
                                                                      .resource?[
                                                                          index]
                                                                      .linkContnent),
                                                          child: const Text(
                                                              "View"))),
                                                ]),
                                          ),
                                        )
                                      ]
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ] else ...[
                      Center(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  bottom: 10, left: 20, right: 20),
                              child: Text(
                                _boothDetails.booth![0].aboutTitle!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ), Container(
                              margin: const EdgeInsets.only(
                                  bottom: 10, left: 20, right: 20),
                              child: Text(
                                  htmlParse(_boothDetails.booth![0].description!))
                            ),

                          ],
                        ),
                      )
                    ]

                    /* ElevatedButton(
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (context) {
                      return const Home();
                    },
                  ),
                );
              },
              child: const Text('Go to second screen'),
            ),*/
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
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

  String htmlParse(String html) {
    var doc = parse(html);
    if (doc.documentElement != null) {
      String parsedstring = doc.documentElement!.text;
      return parsedstring;
      //output without space: HelloThis is fluttercampus.com,Bye!
    }
    return "";
  }

  ListView test() {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              leading: const Icon(Icons.list),
              trailing: const Text(
                "GFG",
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
              title: Text("List item $index"));
        });
  }
}
