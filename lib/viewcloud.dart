import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class viedata extends StatefulWidget {
  const viedata({Key? key}) : super(key: key);

  @override
  State<viedata> createState() => _viedataState();
}

class _viedataState extends State<viedata> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cloud dataview"),),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              print(document.id);
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                subtitle: Text(data['contact']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
