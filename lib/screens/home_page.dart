import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: DrawerScreen(
        setIndex: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      mainScreen: currentScreen(),
      borderRadius: 30,
      showShadow: true,
      angle: 0.0,
      slideWidth: 200,
      menuBackgroundColor: Colors.blue,
    );
  }

  Widget currentScreen() {
    switch (currentIndex) {
      case 0:
        return const HomeScreen(
          title: "Profile",
        );
      case 1:
        return const HomeScreen(
          title: "Lobby",
        );
      case 2:
        return const HomeScreen(
          title: "Exhibit Hall",
        );
      case 3:
        return const HomeScreen(
          title: "Auditorium",
        );
      case 4:
        return const HomeScreen(
          title: "Resource",
        );
      case 5:
        return const HomeScreen(
          title: "Information Desk",
        );
      case 6:
        return const HomeScreen(
          title: "Video Desk",
        );
      case 7:
        return const HomeScreen(
          title: "Booth",
        );
      case 8:
        return const HomeScreen(
          title: "Chat",
        );
      default:
        return const HomeScreen();
    }
  }
}

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key? key, this.title = "Home"}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final widgetOptions = [
    Text('Beer List'),
    Text('Add new beer'),
    Text('Favourites'),
  ];

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      ' Like',
      style: optionStyle,
    ),
    Text(
      ' Home',
      style: optionStyle,
    ),
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
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
          )),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class DrawerScreen extends StatefulWidget {
  final ValueSetter setIndex;

  const DrawerScreen({Key? key, required this.setIndex}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 40, bottom: 40),
            child: const Icon(
              Icons.person_pin,
              size: 80,
              color: Colors.white,
            ),
          ),
          drawerList("Profile", 0),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),
          drawerList("Lobby", 1),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),
          drawerList("Exhibit Hall", 2),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),
          drawerList("Auditorium", 3),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),
          drawerList("Resource", 4),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),
          drawerList("Information desk", 5),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),
          drawerList("Video Vault", 6),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),
          drawerList("Booth", 7),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ),
          drawerList("Chat", 8),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 10, bottom: 20),
          ),
          drawerList("Sign-out  -->", 8),
        ],
      ),
    );
  }

  Widget drawerList(String text, int index) {
    return GestureDetector(
      onTap: () {
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

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ZoomDrawer.of(context)!.toggle();
      },
      icon: const Icon(
        Icons.menu,
        color: Colors.blue,
      ),
    );
  }
}
