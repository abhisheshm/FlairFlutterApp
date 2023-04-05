import 'package:carousel_slider/carousel_slider.dart';
import 'package:flair_app/model/resource.dart';
import 'package:flair_app/network/client.dart';
import 'package:flair_app/screens/home/exihibit_hall.dart';
import 'package:flair_app/screens/home/video%20vault.dart';
import 'package:flair_app/screens/login.dart';
import 'package:flair_app/screens/student_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../chat/chat.dart';
import '../model/auditorium.dart';
import '../model/booth_list.dart';
import '../model/video_vault.dart';
import '../storage/shared_preference.dart';
import 'home/auditorium_list.dart';
import 'home/upper_tab_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  bool auth = false;

  //sts

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: DrawerScreen(
        setIndex: (index) {
          setState(() {
            print("lllll${index}");
            currentIndex = index;
          });
        },
      ),
      mainScreen: currentScreen(auth),
      borderRadius: 30,
      showShadow: true,
      drawerShadowsBackgroundColor: Colors.grey,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      angle: 0.0,
      menuBackgroundColor: Colors.blue,
    );
  }

  Widget currentScreen(auth) {
    switch (currentIndex) {
      case 0:
        return const HomeScreen(
          title: "Lobby",
          currentIndex: false,
        );
      /* case 1:
        return const HomeScreen(
          title: "Profile",
        );*/
      case 1:
        return const HomeScreen(
          title: "Exhibit Hall",
        );
      case 2:
        return const HomeScreen(
          title: "Auditorium",
        );

      case 3:
        return const HomeScreen(
          title: "Resource",
        );
      case 4:
        return const HomeScreen(
          title: "Information Desk",
        );
      case 5:
        return const HomeScreen(
          title: "Video Vault",
        );
      case 6:
        return const HomeScreen(
          title: "Networking",
        );
      case 7:
        return const HomeScreen(
          title: "Chat",
        );
        case 8:
        return const HomeScreen(
          title: "Sign-out",
        );
      default:
        return const HomeScreen();
    }
  }
}

class HomeScreen extends StatefulWidget {
  final String title;
  final bool currentIndex;

  const HomeScreen({Key? key, this.title = "Home", this.currentIndex = false})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Auditorium> auditoriumList;
  List<VideoVault>? videoVaultList;
  List<ResourceDetails>? resourceDetailsList;
  List<BoothList>? boothList;
  var isLoadedAudi = false;
  var isLoadedVideo = false;
  var isLoadedRes = false;
  var isLoadedBooth = false;

  int selectedIndex = 0;
  final widgetOptions = [
    Text('Beer List'),
    Text('Add new beer'),
    Text('Favourites'),
  ];

/*
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
*/

  final List<String> imgList = [
    "assets/images/europe.png",
    "assets/images/slovia.png",
    "assets/images/hungary.png",
    "assets/images/slovakia.png",
    "assets/images/lithuania.png",
    "assets/images/france.png",
    "assets/images/poland.png",
    "assets/images/finland.png",
    "assets/images/freeEducation.png",
    "assets/images/malta.png",
    "assets/images/republic.png",
    "assets/images/UK.png",
    "assets/images/germany.png",
    "assets/images/italy.png",
    "assets/images/sweden.png",
    "assets/images/spain.png",
    "assets/images/portgal.png",
    "assets/images/mgEurope.png",
    "assets/images/latvia.png",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBoothList();
    getAuditoriumData();
    getVideoVaultData();
    getResource();
  }

  getAuditoriumData() async {
    print("kkkkk");
    auditoriumList = (await Client().getAuditorium())!;
    if (auditoriumList != null) {
      setState(() {
        isLoadedAudi = true;
      });
    }
  }

  getVideoVaultData() async {
    print("kkkkk");
    videoVaultList = await Client().getVideoVault();
    if (videoVaultList != null) {
      setState(() {
        isLoadedVideo = true;
      });
    }
  }

  getResource() async {
    print("kkkkk");
    resourceDetailsList = await Client().getResource();
    if (resourceDetailsList != null) {
      setState(() {
        isLoadedRes = true;
      });
    }
  }

  getBoothList() async {
    print("kkkkk");
    boothList = await Client().getBoothList();
    if (boothList != null) {
      setState(() {
        isLoadedBooth = true;
      });
    }
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      ' Like',
      style: optionStyle,
    ),
    // UpperTabBar(),

    /*  Text(
      ' Home',
      style: optionStyle,
    ),*/
    Text(
      ' Chat',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Container(
            width: 200,
            height: 50,
            /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
            child: Image.asset('assets/images/logo.png')),
        centerTitle: true,
        leading: DrawerWidget(),
      ),
      body: getPage(widget.title, widget.currentIndex),
      /*bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.message), label: ""),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue,
              onTap: _onItemTapped,
            ),
          )),*/
    );
  }

  void onItemTapped(int index) {
    setState(() {
      print("lllll");
      selectedIndex = index;
    });
  }

  Widget getPage(String page, bool currentIndex) {
    print(page);
    switch (page) {
      case "Lobby":
        return Center(
          child: getBoothPage(currentIndex),
        );
        break;

      case "Exhibit Hall":
        return Center(
          child: getExhibitHallPage(),
        );
      case "Video Vault":
        return Center(
          child: getVideoVaultPage(),
        );
        break;
      case "Auditorium":
        return Center(
          child: getAuditoriumPage(),
        );
        break;
      case "Resource":
        return Center(
          child: getResourcePage(),
        );
        break;
      case "Chat":
        return const Center(
          child: Chat(),
        );
        break;
      case "Sign-out":
        return Center(
          child: dialogOut(),
        );
        break;
    }
    return const Center(
      child: Text("Coming Soon"),
    );
  }


  Widget dialogOut() {
    print("ppppp");
    return AlertDialog(
      title: Text('Logout'),           // To display the title it is optional
      content: Text('Are you sure?'),   // Message which will be pop up on the screen
      // Action widget which will provide the user to acknowledge the choice
      actions: [
        FlatButton(                     // FlatButton widget is used to make a text to work like a button
          textColor: Colors.black,
          onPressed: () {
            ZoomDrawer.of(context)!.open();
          },             // function used to perform after pressing the button
          child: Text('CANCEL'),
        ),
        FlatButton(
          textColor: Colors.black,
          onPressed: () {
            Navigator.pop(context);

            /* Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => Login())));*/

          },
          child: Text('ACCEPT'),
        ),
      ],
    );
  }

  Widget getAuditoriumPage() {
    return Visibility(
      visible: isLoadedAudi,
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
      child: ListView.builder(
          itemCount: auditoriumList?.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  _launchInBrowser(auditoriumList?[index].link);
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
                                  "${auditoriumList?[index].title}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 100, left: 10, right: 10),
                              child: Center(
                                child: Text(
                                  "Timing:- ${DateFormat('yyyy-MM-dd – kk:mm').format(auditoriumList[index].startDatetime)}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: RaisedButton(
                                    onPressed: () => _launchInBrowser(
                                        auditoriumList?[index].link),
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
          }),
    );
  }

  String convertDateTime(String? date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    DateTime dateTime = dateFormat.parse(date!);
    return dateTime.toString();
  }

  Widget getResourcePage() {
    return Visibility(
      visible: isLoadedRes,
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
      child: ListView.builder(
          itemCount: resourceDetailsList?.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  _launchInBrowser(resourceDetailsList?[index].linkLink);
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
                                  "${resourceDetailsList?[index].linkText}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: RaisedButton(
                                    onPressed: () => _launchInBrowser(
                                        resourceDetailsList?[index].linkLink),
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
          }),
    );
  }

  Widget getBoothPage(bool selectedIndex) {
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if (item.contains("slovia")) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName: "Study in Slovenia",
                                        boothId: 5,
                                      ))));
                            } else if (item.contains("lithuania")) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName: "Study in Lithuania",
                                        boothId: 9,
                                      ))));
                            } else if (item.contains("hungary")) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName: "Study in Hungary",
                                        boothId: 6,
                                      ))));
                            } else if (item.contains("slovakia")) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName: "Study in Slovakia",
                                        boothId: 4,
                                      ))));
                            } else if (item.contains("finland")) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName:
                                            "Study in Finland \/ Denmark",
                                        boothId: 11,
                                      ))));
                            } else if(item.contains("poland")){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName:
                                            "Study in Poland",
                                        boothId: 8,
                                      ))));
                            }else if(item.contains("france")){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName:
                                            "Study in France",
                                        boothId: 10,
                                      ))));
                            }else if(item.contains("freeEducation")){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName:
                                            "Free Education ( Austria\/ Switzerland\/ Germany\/ Luxembourg \/ Norway\/ Iceland\/ Liechtenstein)",
                                        boothId: 12,
                                      ))));
                            }else if(item.contains("malta")){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName:
                                            "Study in Malta\/ Greece \/ Croatia",
                                        boothId: 13,
                                      ))));
                            }else if(item.contains("republic")){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName:
                                            "Study in Czech Republic",
                                        boothId: 2,
                                      ))));
                            }else if(item.contains("UK")){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName:
                                            "Study in UK\/Ireland",
                                        boothId: 1,
                                      ))));
                            }

                            else if(item.contains("germany")){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName:
                                            "Study in Germany",
                                        boothId: 21,
                                      ))));
                            } else if(item.contains("italy")){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName:
                                            "Study in italy",
                                        boothId: 20,
                                      ))));
                            }else if(item.contains("sweden")){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName:
                                            "Study in sweden",
                                        boothId: 19,
                                      ))));
                            }else if(item.contains("spain")){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName:
                                            "Study in spain",
                                        boothId: 18,
                                      ))));
                            }else if(item.contains("portgal")){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName:
                                            "Study in portugal",
                                        boothId: 17,
                                      ))));
                            }else if(item.contains("mgEurope")){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName:
                                            "Study in Management Europe",
                                        boothId: 16,
                                      ))));
                            }else if(item.contains("latvia")){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const UpperTabBar(
                                        boothName:
                                            "Study in latvia",
                                        boothId: 15,
                                      ))));
                            }
                          },
                          child: Image.asset(item,
                              fit: BoxFit.fill, width: 1000.0,height: 230,),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            /*padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      'No. ${imgList.indexOf(item)} image',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),*/
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/lobby1.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 70),
              child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: false,
                  ),
                  items: imageSliders

                  /* imgList
                .map((item) => Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => UpperTabBar(
                                    boothName: boothList?[imgList.length - 1]
                                        .boothName,
                                    boothId:
                                        boothList?[imgList.length - 1].boothId,
                                  ))));
                        },
                        child: Center(
                            child: Image.asset(item,
                                fit: BoxFit.fitHeight, width: 1000)),
                      ),
                    ))
                .toList(),*/
                  )),
          Expanded(
            child: Column(
              children: [
                /*Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("${auditoriumList?[index].title}"),
                    ),*/

                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => AuditoriumList(
                              auditoriumList: auditoriumList,
                            ))));
                    setState(() {
                      _selectedIndex == true;
                      //getPage("Auditorium",2);
                    });
                  },
                  child: Container(
                      margin: const EdgeInsets.only(
                          top: 20, bottom: 30, left: 30, right: 30),
                      child: const Card(
                          child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text("Auditorium"),
                        ),
                      ))),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => ExihbitList(
                                boothList: boothList,
                              ))));
                    },
                    child: Container(
                        margin: const EdgeInsets.only(
                            top: 0, bottom: 30, left: 30, right: 30),
                        child: const Card(
                            child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(
                            child: Text("Exhibition Hall"),
                          ),
                        )))),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => VideoList(
                              videoVaultList: videoVaultList,
                            ))));
                  },
                  child: Container(
                      margin: const EdgeInsets.only(
                          top: 0, bottom: 30, left: 30, right: 30),
                      child: const Card(
                          child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text("Video vault"),
                        ),
                      ))),
                )
              ],
            ),
          )
        ],
      ) /* add child content here */,
    );
  }

  Widget getExhibitHallPage() {
    return Visibility(
      visible: isLoadedBooth,
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
      child: ListView.builder(
          itemCount: boothList?.length,
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
                              cityImage(boothList?[index].boothName),
                              fit: BoxFit.fill,
                              height: 280,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 285, left: 10, right: 10),
                              child: Center(
                                child: Text(
                                  "${boothList?[index].boothName}",
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
                                                  boothName: boothList?[index]
                                                      .boothName,
                                                  boothId:
                                                      boothList?[index].boothId,
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
          }),
    );
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

  Widget getVideoVaultPage() {
    return Visibility(
      visible: isLoadedVideo,
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
      child: ListView.builder(
          itemCount: videoVaultList?.length,
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
                                    "${videoVaultList?[index].linkText}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                      onPressed: () => _launchInBrowser(
                                          videoVaultList?[index].linkContnent),
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
          }),
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

class DrawerScreen extends StatefulWidget {
  final ValueSetter setIndex;

  const DrawerScreen({Key? key, required this.setIndex}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String uName = "";

  @override
  void initState() {
    super.initState();
    getUserName().then((username) => {
          if (username == null)
            {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => StudentLogin())))
            }
          else
            {
              setState(() {
                uName = username;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [

            Container(
              margin: const EdgeInsets.only(left: 40, bottom: 0),
              child: const Icon(
                Icons.person_pin,
                size: 80,
                color: Colors.white,
              ),
            ),

            Container(
              width: 20,
              height: 20,

              margin: const EdgeInsets.only(left: 40, bottom: 200),
              child: Center(child: IconButton(
                onPressed: () {
                  ZoomDrawer.of(context)!.close();
                },
                // ZoomDrawer.of(context)!.toggle();
                // ZoomDrawer.of(context)!.close();

                icon:  const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),)


            ),

          ],),

          drawerList("Lobby", 0),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),
          /*  drawerList("Profile", 1),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),*/
          drawerList("Exhibit Hall", 1),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),
          drawerList("Auditorium", 2),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),
          drawerList("Resource", 3),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),
          /*drawerList("Information desk", 4),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),*/
          drawerList("Video Vault", 5),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),
          /*drawerList("Networking", 6),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),*/
          drawerList("Chat", 7),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),

          drawerList("Sign-out", 8),
        ],
      ),
    );
  }

  Widget drawerList(String text, int index) {
    return GestureDetector(
      onTap: () {
        ZoomDrawer.of(context)!.close();
        widget.setIndex(index);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, bottom: 12),
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerWidget extends StatefulWidget {


  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
 bool close = true;

  @override
  Widget build(BuildContext context) {
    if(close){
      return IconButton(
          onPressed: () {
            print("llll");
            ZoomDrawer.of(context)!.open();
            //ZoomDrawer.of(context)!.toggle();
            // ZoomDrawer.of(context)!.close();
          },
          icon:  const Icon(
            Icons.menu,
            color: Colors.blue,
          )
      );

    }else{
      return IconButton(
          onPressed: () {
            print("llll");
            ZoomDrawer.of(context)!.open();
            close = false;
            //ZoomDrawer.of(context)!.toggle();
            // ZoomDrawer.of(context)!.close();
          },
          icon:  const Icon(
            Icons.close,
            color: Colors.blue,
          )
      );

    }
  }

}
