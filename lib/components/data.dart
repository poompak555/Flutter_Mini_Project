import 'dart:math';
import 'package:beautiful_ui/components/index.dart';
import 'package:beautiful_ui/components/readData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class Data extends StatefulWidget {
  final String status;
  const Data({Key key, this.status}) : super(key: key);
  
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  String type;
  String name;
  String hp;
  String doc_num;
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

 

  @override
  void initState() {
    super.initState();
    EasyLoading.init();
  }

  @override //+
 
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Colors.pink[100]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: StreamBuilder<User>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snap) {
                final user = snap.data;
                if (user != null) {
                  return Text(
                    'Signed-in with ${user.email}',
                    style: TextStyle(color: Colors.black),
                  );
                }
                return Text('Sign-Out',style: TextStyle(color: Colors.black),);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.black),
                  onChanged: (doc) => doc_num = doc,
                  obscureText: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Document ID',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                Text(""),
                TextField(
                 style: TextStyle(color: Colors.black),
                  onChanged: (nam) => name = nam,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'doc_name',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                Text(""),
                TextField(
                  style: TextStyle(color: Colors.black),
                  onChanged: (doctype) => type = doctype,
                  obscureText: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Type',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                Text(""),
                TextField(
                  style: TextStyle(color: Colors.black),
                  onChanged: (dochp) => hp = dochp,
                  obscureText: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'HP',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                 Text(""),
                
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
                   /* Text(
                      "Forgot Password",
                      style: TextStyle(color: Colors.black),
                    )*/
                  ],
                )
              ],
            ),
          ),
           Column(mainAxisSize: MainAxisSize.min,
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
            // buildButtonSignIn(),
            
            // buildButtonCreate(),
             
             buildButtonCreateData(),
             buildButtonUpdateData(),
             buildButtonReadData(),
             buildButtonSignOut(),
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
                        MaterialStateProperty.all<Color>(Colors.pink[900]),
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
    Route route = MaterialPageRoute(
          builder: (context) =>
              MaterialApp(home: Scaffold(body: Index())));
      Navigator.push(context, route);
  }
/*
  Container buildButtonSignIn() {
    return Container(
        constraints: BoxConstraints.expand(width: 300,height: 50),
        child: InkWell(
        child: Text("Sign in",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: ()  {
             onClickSignIn();
            },
    ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.pink[900]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }*/

  Container buildButtonSignOut() {
    return Container(
        constraints: BoxConstraints.expand(width: 300,height: 50),
        child: InkWell(
        child: Text("Sign Out",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white)),
            onTap: (){
              onClickSignOut();
            },
    ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.pink[900]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

 /* Container buildButtonCreate() {
    return Container(
        constraints: BoxConstraints.expand(width: 300,height: 50),
        child: InkWell(
        child: Text("Create User",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () async {
              await createUser();
            },
    ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.pink[900]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }
*/
   Container buildButtonCreateData() {
    return Container(
        constraints: BoxConstraints.expand(width: 300,height: 50),
        child: InkWell(
        child: Text("Create Data",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white)),
            onTap: ()  {
             createData();
            },
    ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.pink[900]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Container buildButtonUpdateData() {
    return Container(
        constraints: BoxConstraints.expand(width: 300,height: 50),
        child: InkWell(
        child: Text("Update",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white)),
            onTap: ()  {
             UpdateData();
            },
    ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.pink[900]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

 /* Future onClickSignIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: "$email", password: "$password");     
      EasyLoading.showSuccess("Sign-in Complete");
      print("Email : $email");
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
  }*/

  void createData() {
    final CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        
        .add({'name': '$name', 'type': '$type' , 'hp': int.parse('$hp') })
        .then((value) => print('success'))
        .catchError((e) => print(e));
  }

  void UpdateData() {

    final CollectionReference users =
              FirebaseFirestore.instance.collection('users');
          users
            .doc("$doc_num")
              .update({'hp': int.parse('$hp') , 'name': '$name', 'type': '$type'})
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
