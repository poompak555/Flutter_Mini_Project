import 'dart:math';
import 'package:beautiful_ui/components/Data.dart';
import 'package:beautiful_ui/components/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';

int hp_comp = 0;
bool greater = true;
bool less = true;

class ViewData extends StatefulWidget {
  final String status;
  const ViewData({Key key, this.status}) : super(key: key);

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
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
    //print(greater);
    //print(less);
    //print(hp_comp);
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    return Container(
      decoration: new BoxDecoration(color: HexColor("0f156d")),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /* Center(
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
          ),*/
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              // padding: const EdgeInsets.all(8),

              children: [
                TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (hp_t) => hp = hp_t,
                  obscureText: false,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: HexColor("DCE313"), width: 2.0),
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: HexColor("DCE313"), width: 2.0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'HP',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                Text(""),
                Center(
                  //height: 100, // constrain height
                  child: RealtimeCollection(
                    users: users,
                  ),
                ),
                /*
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
                */
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
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // buildButtonSignIn(),

              // buildButtonCreate(),
              buildButtonGreaterThan(),
              buildButtonLessThan(),
              buildButtonRefresh(),
              buildButtonBack(),
              //buildButtonCreateData(),
              //buildButtonUpdateData(),
              //buildButtonSignOut(),
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
        builder: (context) => MaterialApp(home: Scaffold(body: Index())));
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
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Sign Out",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () {
            onClickSignOut();
          },
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.pink[900],
            gradient: new LinearGradient(
                colors: [Colors.red, Colors.cyan],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft)),
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
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Create Data",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () {
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
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Update",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () {
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
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    users
        .add({'name': '$name', 'type': '$type', 'hp': '$hp'})
        .then((value) => print('success'))
        .catchError((e) => print(e));
  }

  void UpdateData() {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    users
        .doc("$doc_num")
        .update({'hp': '$hp', 'name': '$name', 'type': '$type'})
        .then((value) => print('updated!'))
        .catchError((e) => print('update error'));
  }

  Container buildButtonBack() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Back",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () {
            goBack();
          },
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.pink[900],
            gradient: new LinearGradient(
                colors: [Colors.purple[700], Colors.orange[600]],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft)),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  void goBack() {
    Route route = MaterialPageRoute(
        builder: (context) => MaterialApp(home: Scaffold(body: Data())));
    Navigator.push(context, route);
  }

  Container buildButtonRefresh() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Refresh",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () {
            refresh();
          },
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.pink[900],
            gradient: new LinearGradient(
                colors: [Colors.purple[700], Colors.orange[600]],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft)),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  void refresh() {
    greater = true;
    less = true;

    Route route = MaterialPageRoute(
        builder: (context) => MaterialApp(home: Scaffold(body: ViewData())));
    Navigator.push(context, route);
  }

  Container buildButtonGreaterThan() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Greater Than",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () {
            comp_great();
          },
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.pink[900],
            gradient: new LinearGradient(
                colors: [Colors.purple[700], Colors.orange[600]],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft)),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  void comp_great() {
    greater = true;
    less = false;
    hp_comp = int.parse('$hp');

    Route route = MaterialPageRoute(
        builder: (context) => MaterialApp(home: Scaffold(body: ViewData())));
    Navigator.push(context, route);
  }

   Container buildButtonLessThan() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Less Than",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () {
            comp_less();
          },
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.pink[900],
            gradient: new LinearGradient(
                colors: [Colors.purple[700], Colors.orange[600]],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft)),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  void comp_less() {
    greater = false;
    less = true;
    hp_comp = int.parse('$hp');

    Route route = MaterialPageRoute(
        builder: (context) => MaterialApp(home: Scaffold(body: ViewData())));
    Navigator.push(context, route);
  }

  
}

class RealtimeCollection extends StatelessWidget {
  const RealtimeCollection({
    Key key,
    @required this.users,
  }) : super(key: key);

  final CollectionReference users;

  @override
  Widget build(BuildContext context) {
    if ((greater == true) && (less == false)) {
      return StreamBuilder(
          stream: users
              .where('hp', isGreaterThan: hp_comp)
              .orderBy('hp', descending: false)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
            if (snap.hasError != false) {
              return Text('error');
            }

            if (snap.connectionState == ConnectionState.waiting) {
              return Text('loading....');
            }
            return ListView(
              shrinkWrap: true,
              children: snap.data.docs.map((doc) {
                print(doc.data().toString());
                return Text(doc.data().toString(),style: TextStyle(color: Colors.white),);
              }).toList(),
            );
          });
    } else if ((greater == false) && (less == true)) {
      return StreamBuilder(
          stream: users
              .where('hp', isLessThan: hp_comp)
              .orderBy('hp', descending: false)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
            if (snap.hasError != false) {
              return Text('error');
            }

            if (snap.connectionState == ConnectionState.waiting) {
              return Text('loading....');
            }
            return ListView(
              shrinkWrap: true,
              children: snap.data.docs.map((doc) {
                print(doc.data().toString());
                return Text(doc.data().toString(),style: TextStyle(color: Colors.white),);
              }).toList(),
            );
          });
    } else if ((greater == true) && (less == true)) {
      return StreamBuilder(
          stream: users.orderBy('hp', descending: false).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
            if (snap.hasError != false) {
              return Text('error');
            }

            if (snap.connectionState == ConnectionState.waiting) {
              return Text('loading....');
            }
            return ListView(
              shrinkWrap: true,
              children: snap.data.docs.map((doc) {
                print(doc.data().toString());
                return Text(doc.data().toString(),style: TextStyle(color: Colors.white),);
              }).toList(),
            );
          });
    }
  }
}

/*FutureBuilder(
    future: dbRef.once(),
    builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
        if (snapshot.hasData) {
        lists.clear();
        Map<dynamic, dynamic> values = snapshot.data.value;
        values.forEach((key, values) {
            lists.add(values);
        });
        return new ListView.builder(
            shrinkWrap: true,
            itemCount: lists.length,
            itemBuilder: (BuildContext context, int index) {
                return Card(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Text("Name: " + lists[index]["name"]),
                    Text("Age: "+ lists[index]["age"]),
                    Text("Type: " +lists[index]["type"]),
                    ],
                ),
                );
            });
        }
        return CircularProgressIndicator();
    })*/
