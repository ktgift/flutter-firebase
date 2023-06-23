import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ShowDialogData extends StatelessWidget {
  String fname;
  String lname;
  String email;
  String nickname;
  String room;

  ShowDialogData(
    this.fname, this.lname, this.email, this.nickname, this.room
  );

  Text generateText(String label, String value) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: '$label: ', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[700])),
      TextSpan(text: value, style: TextStyle(color: Color.fromARGB(255, 84, 83, 83)))
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('ข้อมูลนักเรียน', style: TextStyle(fontWeight: FontWeight.bold),),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              generateText('ชื่อ', fname),
              generateText('นามสกุล', lname),
              generateText('ชื่อเล่น', nickname),
              generateText('ห้อง', room),
              generateText('อีเมล', email),
            ],
          ) 
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          child: const Text('ปิด')
        )
      ],
    );
  }
}