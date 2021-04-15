import 'package:beautiful_ui/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'components/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // await auth.signOut();
 \ await createUserAc();

  runApp(MaterialApp(home: Scaffold(body: TryFirestore())));
}

class TryFirestore extends StatefulWidget {
  TryFirestore({Key key}) : super(key: key);

  @override
  _TryFirestoreState createState() => _TryFirestoreState();
}

class _TryFirestoreState extends State<TryFirestore> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
         //child: RealtimeCollection(users: users,),
      
           child: Column(
            
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
             //  RealtimeCollection(users: users,),
              SizedBox(
                  height: 100, // constrain height
                  child: RealtimeCollection(users: users,),
                ),
               Signin(),
               CreateDataButton(),
               UpdateDataButton(),
               UpdateDataButton2(),
               RemoveDataButton(),
               
               
             // OneTimeRead(users: users),
                
             ],
           ) 
          ),
    );
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
    return StreamBuilder(
        stream: users
            .where('hp', isGreaterThan: 1000)
            .orderBy('hp', descending: false)
            .limit(2)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
          if (snap.hasError != false) {
            return Text('error');
          }

          if (snap.connectionState == ConnectionState.waiting) {
            return Text('loading....');
          }
          return ListView(
            children: snap.data.docs.map((doc) {
              print(doc.data().toString());
              return Text(doc.data().toString());
            }).toList(),
          );
        });
  }
}

class RealTimeDocRead extends StatelessWidget {
  const RealTimeDocRead({
    Key key,
    @required this.users,
  }) : super(key: key);

  final CollectionReference users;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: users.doc('XJX30tuA9dg7nfspqO3S').snapshots(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Text('loading...');
          }
          print(snap.data.data());
          return Text(UserC.fromJson(snap.data.data()).toString());
        });
  }
}

class OneTimeRead extends StatelessWidget {
  const OneTimeRead({
    Key key,
    @required this.users,
  }) : super(key: key);

  final CollectionReference users;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: users.doc('XJX30tuA9dg7nfspqO3S').get(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            final UserC user = UserC.fromJson(snap.data.data());
            print(user);
            return Text(user.toString());
          }

          return Text('data!');
        });
  }
}

class RemoveDataButton extends StatelessWidget {
  const RemoveDataButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          final CollectionReference users =
              FirebaseFirestore.instance.collection('users');
          users
              .doc('ewwwew')
              .delete()
              .then((value) => print('delete success!'))
              .catchError((e) => print(e));
        },
        child: Text('remove data'));
  }
}

class UpdateDataButton extends StatelessWidget {
  const UpdateDataButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          final CollectionReference users =
              FirebaseFirestore.instance.collection('users');
          users
              .doc("XJX30tuA9dg7nfspqO3S")
              .update({'hp': 1200 , 'name': 'Darius', 'type': 'Mage'})
              .then((value) => print('updated!'))
              .catchError((e) => print('update error'));
        },
        child: Text('update'));
  }
}

class CreateDataButton extends StatelessWidget {
  const CreateDataButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: createUser,
      child: Text('create data'),
    );
  }

  void createUser() {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    users
        .add({'name': 'Dawn Breaker', 'type': 'strength' , 'hp': 1500})
        .then((value) => print('success'))
        .catchError((e) => print(e));
  }
}

class UpdateDataButton2 extends StatelessWidget {
  const UpdateDataButton2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          final CollectionReference users =
              FirebaseFirestore.instance.collection('users');
          users
              .doc("XJX30tuA9dg7nfspqO3S")
              .update({'hp': 1200 , 'name': 'Garen', 'type': 'Tank'})
              .then((value) => print('updated!'))
              .catchError((e) => print('update error'));
        },
        child: Text('update2'));
  }
}

 Future createUserAc() async {
  try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: "poompak@example.com",
    password: "poomza"
  );
  } on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
  } catch (e) {
  print(e);
  }
}