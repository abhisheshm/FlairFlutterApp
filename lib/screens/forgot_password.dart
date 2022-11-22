

import 'package:flair_app/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 102, 138, 195),
     /* appBar: AppBar(
        title: const Text("Login Page"),
      ),*/
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Center(
                child: Container(
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Text("FORGOT YOUR PASSWORD?",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              ),
            ), Padding(
              padding: const EdgeInsets.only(top: 80.0,bottom: 60.0),
              child: Center(
                child: Container(
                  width: 300,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Text(
                      "Enter your registered email below to receive password reset instruction",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),
                      )
                    ),
              ),
            ),
             Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.only(left: 15,right: 15),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.email_outlined,color: Colors.yellowAccent),
                    border: OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(10.0),
                    ),
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),

            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.only(right: 30.0,left: 30.0,top: 5.0,bottom: 15.0),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  // ignore: prefer_const_constructors
                  // set up the button
                  Widget okButton = TextButton(
                    child: Text("OK"),
                    onPressed: () { 
                      Navigator.of(context).pop();
                    },
                  );

                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    content: Text("you will get an email in inbox"),
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
                },
                child: const Text(
                  'Send Reset Link',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text('Remember Password?',style: TextStyle(color: Colors.white,fontSize: 13),),
            TextButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginDemo()));
              }, 
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),)
              ]
            )
          ],
        ),
      ),
    );
  }
}