import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
        child: Column(
          children: [
            Text('1'),
            Text('2')
        ]),
      ),
    );
  }
}