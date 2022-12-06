import 'package:flair_app/screens/home/video_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

import '../home_page.dart';

class UpperTabBar extends StatefulWidget {
  const UpperTabBar({Key? key}) : super(key: key);

  @override
  _UpperTabBarPageState createState() => _UpperTabBarPageState();
}

class _UpperTabBarPageState extends State<UpperTabBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,

            //mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSlidingSegmentedControl<int>(
                isStretch: true,
                initialValue: 2,
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
                    print(v);
                  }
                  print(v);
                },
              ),
              // const SizedBox(height: 16),
              const SizedBox(height: 20),
              Container(
                height: 500,
                margin: EdgeInsets.all(10),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Container(
                      width: double.maxFinite,
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(5.0)),
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/card_bg.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10.00)),
                    Container(
                      width: double.maxFinite,
                      height: 120.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(5.0)),
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/card_bg.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5.00)),

                    Container(
                      width: double.maxFinite,
                      height: 120.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(5.0)),
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/card_bg.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5.00)),

                    Container(
                      width: double.maxFinite,
                      height: 120.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(5.0)),
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/card_bg.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5.00)),

                    Container(
                      width: double.maxFinite,
                      height: 120.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(5.0)),
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/card_bg.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(5.00)),

                    Container(
                      width: double.maxFinite,
                      height: 120.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(5.0)),
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/card_bg.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              )

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
        ),
      ),
    );
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
