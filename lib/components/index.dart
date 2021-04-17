import 'dart:math';
import 'package:beautiful_ui/components/Data.dart';
import 'package:beautiful_ui/components/readData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class Index extends StatefulWidget {
  final String status;
  const Index({Key key, this.status}) : super(key: key);
  
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  String status;
  String email;
  String password;
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

 

  @override
  void initState() {
    super.initState();
    EasyLoading.init();
  }

  @override //+
 
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Colors.grey[850]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        /*  Center(
            child: StreamBuilder<User>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snap) {
                final user = snap.data;
                if (user != null) {
                  return Text(
                    'Signed-in with ${user.email}',
                    style: TextStyle(color: Colors.white),
                  );
                }
                return Text('Sign-Out',style: TextStyle(color: Colors.black),);
              },
            ),
          ),*/
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                 style: TextStyle(color: Colors.white),
                  onChanged: (mail) => email = mail,
                 decoration: InputDecoration( 
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink[200],width: 2.0),
                          borderRadius: BorderRadius.circular(30)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink[200],width: 2.0),
                            borderRadius: BorderRadius.circular(30),
                          ),
                      labelText: 'email',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                Text(""),
                TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (pass) => password = pass,
                  obscureText: true,
                  decoration: InputDecoration( 
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink[200],width: 2.0),
                          borderRadius: BorderRadius.circular(30)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink[200],width: 2.0),
                            borderRadius: BorderRadius.circular(30),
                          ),
                      labelText: 'password',
                      labelStyle: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      "Forgot Password",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          ),
           Column(mainAxisSize: MainAxisSize.min,
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             buildButtonSignIn(),
             //buildButtonSignOut(),
             buildButtonCreate(),
           //  buildButtonReadData(),
            // buildButtonCreateData(),
            // buildButtonUpdateData(),
           ],
           )
           /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: onClickSignIn,
                child: Text('sign-In'),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue[300]),
                        ),
              ),
              ElevatedButton(
                  onPressed: onClickSignOut, child: Text('sign-out')),
            ],
          ),*/
        ],
      ),
    );
  }

  void onClickSignOut() async {
    await FirebaseAuth.instance.signOut();
    EasyLoading.showSuccess("Sign-Out Complete");
  }

  Container buildButtonSignIn() {
    return Container(
        constraints: BoxConstraints.expand(width: 300,height: 50),
        child: InkWell(
        child: Text("Sign in",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white)),
            onTap: ()  {
             onClickSignIn();
            },
    ),
         decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), 
            color: Colors.pink[900],
            gradient: new LinearGradient(
              colors: [Colors.purple[700],Colors.orange[600]],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft
              )
            ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Container buildButtonSignOut() {
    return Container(
        constraints: BoxConstraints.expand(width: 300,height: 50),
        child: InkWell(
        child: Text("Sign Out",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: (){
              onClickSignOut();
            },
    ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), 
            color: Colors.pink[900],
            gradient: new LinearGradient(
              colors: [Colors.purple[700],Colors.orange[600]],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft
              )
            ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Container buildButtonCreate() {
    return Container(
        constraints: BoxConstraints.expand(width: 300,height: 50),
        child: InkWell(
        child: Text("Create User",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white)),
            onTap: () async {
              await createUser();
            },
    ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), 
            color: Colors.pink[900],
            gradient: new LinearGradient(
              colors: [Colors.orange[600],Colors.purple[700]],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft
              )
            ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

   Container buildButtonCreateData() {
    return Container(
        constraints: BoxConstraints.expand(width: 300,height: 50),
        child: InkWell(
        child: Text("Create Data",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: ()  {
             createData();
            },
    ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.blue[300]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Container buildButtonUpdateData() {
    return Container(
        constraints: BoxConstraints.expand(width: 300,height: 50),
        child: InkWell(
        child: Text("Update",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: ()  {
             UpdateData();
            },
    ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.blue[300]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Future onClickSignIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: "$email", password: "$password");     
      EasyLoading.showSuccess("Sign-in Complete");
      print("Email : $email");
      Route route = MaterialPageRoute(
          builder: (context) =>
              MaterialApp(home: Scaffold(body: Data())));
      Navigator.push(context, route);
    } 
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        } 
      }
      catch(error){
        print(e);
      }
    }

  Future createUser() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: "$email", password: "$password");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The Password is to weak');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  }

  void createData() {
    final CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .add({'name': 'Dawn Breaker', 'type': 'strength' , 'hp': 1500})
        .then((value) => print('success'))
        .catchError((e) => print(e));
  }

  void UpdateData() {

    final CollectionReference users =
              FirebaseFirestore.instance.collection('users');
          users
            .doc("RLAw9CXWbpQlEkzOo0Uh")
              .update({'hp': 1200 , 'name': 'Darius', 'type': 'Mage'})
              .then((value) => print('updated!'))
              .catchError((e) => print('update error'));
  }

  Container buildButtonReadData() {
    return Container(
        constraints: BoxConstraints.expand(width: 300,height: 50),
        child: InkWell(
        child: Text("View Data",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white)),
            onTap: (){
              goToRead();
            },
    ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.pink[900]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }
  
  void goToRead(){
    Route route = MaterialPageRoute(
          builder: (context) =>
              MaterialApp(home: Scaffold(body: ViewData())));
      Navigator.push(context, route);

  }



}
