import 'package:firbase_auth/viewrealtime.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class realtimedatabase extends StatefulWidget {
  const realtimedatabase({Key? key}) : super(key: key);

  @override
  State<realtimedatabase> createState() => _realtimedatabaseState();
}

class _realtimedatabaseState extends State<realtimedatabase> {

 TextEditingController t1=TextEditingController();
 TextEditingController t2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Firebase realtime database"),),
    body: Column(
        children: [
          TextField(controller: t1,),
          TextField(controller:t2 ,),
          ElevatedButton(onPressed: () async {
              //only real time data insert
            DatabaseReference ref = FirebaseDatabase.instance.ref("Student").push();

            await ref.set({
              "name": "${t1.text}",
              "contact": "${t2.text}",

            });

          }, child: Text("Submit data")),

          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return view();
            },));
          }, child: Text("Realtime Viewdata")),
      ],
    ),
    );
  }
}
