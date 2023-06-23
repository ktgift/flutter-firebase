import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ListTileRoster extends StatelessWidget {
  String fname;
  String lname;
  String email;
  String nickname;

  ListTileRoster(this.fname, this.lname, this.email, this.nickname);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(child: Text(fname[0]),),
          title: Text('ชื่อ: $fname $lname'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text('ชื่อเล่น: ', style: TextStyle(fontWeight: FontWeight.bold),),
                Text(nickname)
              ],),
              Row(children: [
                Text('email: ', style: TextStyle(fontWeight: FontWeight.bold),),
                Text(email)
              ],),
            ]
          ),
        ),
        Divider()
      ],
    );
  }
}