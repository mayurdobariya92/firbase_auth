import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase_auth/viewcloud.dart';
import 'package:firbase_auth/viewrealtime.dart';
import 'package:flutter/material.dart';

class clouddatabase extends StatefulWidget {
  const clouddatabase({Key? key}) : super(key: key);

  @override
  State<clouddatabase> createState() => _clouddatabaseState();
}

class _clouddatabaseState extends State<clouddatabase> {

  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Cloud database"),),
      body: Column(
        children: [
          TextField(controller: t1,),
          TextField(controller:t2 ,),
          ElevatedButton(onPressed: () async {
            CollectionReference users = FirebaseFirestore.instance.collection('Student');
            users.add({
              'name': "${t1.text}",
              'contact': "${t2.text}",

            })
                .then((value) => print("User Added"))
                .catchError((error) => print("Failed to add user: $error"));

          }, child: Text("Submit data")),

          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return viedata();
            },));
          }, child: Text("Cloud Viewdata")),
        ],
      ),
    );
  }
}
