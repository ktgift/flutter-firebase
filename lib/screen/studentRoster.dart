import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_firebase/model/ListTileRoster.dart';

class StudentRoster extends StatefulWidget {
  const StudentRoster({super.key});

  @override
  State<StudentRoster> createState() => _StudentRosterState();
}

class _StudentRosterState extends State<StudentRoster> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('รายชื่อนักเรียน')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('students').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(),);
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                return ListTileRoster(doc['fname'], doc['lname'], doc['email'], doc['nickname'], doc['room']);
              },
              // children: snapshot.data!.docs.map((doc) {
              //   return ListTileRoster(doc['fname'], doc['lname'], doc['email']);
              // }).toList(),
            );
          }
        ),
      ),
    );
  }
}