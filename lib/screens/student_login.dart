import 'package:flair_app/screens/home_page.dart';
import 'package:flair_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flair_app/model/login_response.dart';
import 'package:flair_app/network/client.dart';
import 'package:flair_app/storage/shared_preference.dart';


class StudentLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentLoginDemo(),
    );
  }
}

class StudentLoginDemo extends StatefulWidget {
  @override
  _StudentLoginDemoState createState() => _StudentLoginDemoState();
}

class _StudentLoginDemoState extends State<StudentLoginDemo> {
  TextEditingController usernameController = TextEditingController();


  Future resolveUser() async {
    String? uName = await getUserName();
    if(uName != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: ((context) => Home())));
    }
  }

  @override
  void initState() {
    super.initState();
    resolveUser();
  }

  Future handleLogin() async {
    if(usernameController.text != ""){
      UserDetail? userDetail = await Client().loginAsync(usernameController.text);
      if(userDetail != null){
        await setUserId(userDetail.userId ?? "");
        await setUserName(userDetail.userName ?? "");
        Navigator.of(context).push(MaterialPageRoute(builder: ((context) => Home())));
      }
      return;
    }
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { 
        Navigator.of(context).pop();
      },
    );
    // set AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Please enter valid username"),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 243, 233, 1),
     /* appBar: AppBar(
        title: const Text("Login Page"),
      ),*/
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 126.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 50,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/logo.png')),
              ),
            ), Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Center(
                child: Container(
                    height: 100,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Text("WELCOME TO \n E-SCHEDULER",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              ),
            ),
             Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(10.0),
                    ),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
             
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  handleLogin();
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
              },
              child: const Text(
                'Admin Login',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            const Text('Don'"t'have an account? Sign up" )
          ],
        ),
      ),
    );
  }
}