import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_firebase/model/GradeColor.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {

  GradeColor _getCircleAvatarColor(int score) {
    if(score <= 49) {
      return GradeColor('F', Colors.red[300]!);
    } else if (score >= 50 && score <= 59) {
      return GradeColor('D', Colors.yellow[300]!);
    } else if (score >= 60 && score <= 69) {
      return GradeColor('C', Colors.amber[400]!);
    } else if (score >= 70 && score <= 79) {
      return GradeColor('B', Colors.blue[300]!);
    } else {
      return GradeColor('A', Colors.green[400]!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('รายงานผลคะแนนสอบ')),
      body: StreamBuilder(
        //FirebaseFirestore.instance.collection('ขื่อ collection').snapshots() ตัว snapshots จะได้ข้อมูลมาเป็น json
        stream: FirebaseFirestore.instance.collection('students').snapshots(),
        //AsyncSnapshot<QuerySnapshot> คือตัวที่ไปดึงข้อมูล
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            //กรณีไม่มีข้อมูล
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            //การดึงข้อมูลที่ละแถว จาก snapshot
            children: snapshot.data!.docs.map((document) {
              int score = int.parse(document['score']) ?? 0;
              GradeColor calGrade = _getCircleAvatarColor(score);
              Color avatarColor = calGrade.color;
              String grade = calGrade.grade;
              
              return Container(
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: avatarColor,
                        child: FittedBox(
                          child: Text(document['score'], style:TextStyle(color: Colors.black)),
                        )),
                    title: Text(document['fname'] + " " + document['lname'],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    subtitle: Text(document['email']),
                    trailing: Text(grade, style: TextStyle(fontSize: 20, color: Colors.grey),),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
