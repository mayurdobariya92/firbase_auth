import 'package:firbase_auth/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class dashbord extends StatefulWidget {
  const dashbord({Key? key}) : super(key: key);

  @override
  State<dashbord> createState() => _dashbordState();
}

class _dashbordState extends State<dashbord> {

  User ?user;
  @override
  void initState() {
    super.initState();
     user = FirebaseAuth.instance.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () async {
          await GoogleSignIn().signOut();
          await FirebaseAuth.instance.signOut();

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return fireauth();
          },));
        }, icon: Icon(Icons.logout)),

      ],),body: Column(children: [
        Text("${user!.displayName}"),
      Text("${user!.email}"),
      Text("${user!.photoURL}"),
      Text("${user!.phoneNumber}"),
    ]),
    );
  }
}
