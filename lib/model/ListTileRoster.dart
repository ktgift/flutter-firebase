import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase/model/showDialog.dart';

class ListTileRoster extends StatelessWidget {
  String fname;
  String lname;
  String email;
  String nickname;
  String room;

  ListTileRoster(this.fname, this.lname, this.email, this.nickname, this.room);

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
          onTap: () {
            showDialog(
              context: context, 
              builder: (BuildContext context) {
                return ShowDialogData(fname, lname, email, nickname, room);
              } 
            );
          },
        ),
        Divider()
      ],
    );
  }
}