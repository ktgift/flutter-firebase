import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_firebase/firebase_options.dart';
import 'package:flutter_firebase/model/Student.dart';
import 'package:form_field_validator/form_field_validator.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextStyle headerText = TextStyle(
    fontSize: 16, 
    fontWeight: FontWeight.bold, 
    color: Colors.grey[700]
  );

  final formKey = GlobalKey<FormState>(); //เมื่อมันการกดบันทึก มันจะดึงข้อมูลใน field มาเก็บไว้ใน formState
  Student myStudent = Student(); //ประกาศ obj จาก class student

  //เตรียม fireBase
  final Future<FirebaseApp> firebase = Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
      options: FirebaseOptions(
          apiKey: 'AIzaSyCgyiYPs9xsSCXMlN-CrsgoaKxiTMV8cFA',
          appId: '1:526901478982:android:841f852f739d9814d32c47',
          messagingSenderId: '526901478982',
          projectId: 'score-record-flutter-app')
      );

  //สร้าง collection
  CollectionReference _studentCollection = FirebaseFirestore.instance.collection("students");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          //กรณีเชื่อมต่อแล้วมี error
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: Text('Error')),
              body: Center(child: Text("${snapshot}")),
            );
          }
          // ถ้าไม่เจอ error  และ load เสร็จ ให้แสดง หน้า form
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text('แบบฟอร์มบันทึกข้อมูลนักเรียน'),
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                    key: formKey, //ผูก formkey ที่เราสร้่าง
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ชื่อ:',
                            style: headerText,
                          ),
                          TextFormField(
                            validator: RequiredValidator(errorText:'กรุณากรอกชื่อ'), //ใส่ validator ห้ามว่าง และ ใส่ massage error
                            onSaved: (String? fname) {
                              myStudent.fname =
                                  fname; //นำค่าไปผูกกับ obj myStudent
                            },
                          ),
                          SizedBox(height: 18,),
                          Text('นามสกุล:', style: headerText),
                          TextFormField(
                            validator: RequiredValidator(errorText: 'กรุณากรอกนามสกุล'),
                            onSaved: (String? lname) {
                              myStudent.lname = lname;
                            },
                          ),
                          SizedBox(height: 18,),
                          Text('ชื่อเล่น:', style: headerText),
                          TextFormField(
                            validator: RequiredValidator(errorText: 'กรุณากรอกชื่อเล่น'),
                            onSaved: (String? nickname) {
                              myStudent.nickname = nickname;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 18),
                          Text('อีเมล:', style: headerText),
                          TextFormField(
                            validator: MultiValidator([
                              EmailValidator(errorText:'รูปแบบอีเมลไม่ถูกต้อง'), //เช็คว่าเป็นรูปแบบอีเมลไหม
                              RequiredValidator(errorText: 'กรุณากรอกอีเมล')
                            ]), //MultiValidator ใช้ระบุ validate มากกว่า 1
                            onSaved: (String? email) {
                              myStudent.email = email;
                            },
                            keyboardType: TextInputType.emailAddress, //กำหนดการแสดงคีย์บอร์ดให้แสดงเป็นของการกรอกอีเมล
                          ),
                          SizedBox(height: 18,),
                          Text('ห้อง:', style: headerText),
                          TextFormField(
                            validator: RequiredValidator(errorText: 'กรุณากรอกเลขห้อง'),
                            onSaved: (String? room) {
                              myStudent.room = room;
                            },
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Text('คะแนน:', style: headerText),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกคะแนน';
                              }
                              final score = int.parse(value);
                              if(score > 100) {
                                return 'คะแนนต้องไม่เกิน 100';
                              }
                            },
                            onSaved: (String? score) {
                              myStudent.score = score ?? '';
                            },
                            keyboardType: TextInputType.number, //กำหนดคีย์บอร์ดให้แสดงเป็นตัวเลข
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 18.0, 0, 0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Text(
                                  'บันทึก',
                                  style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    //ให้ form ทำการ validate
                                    formKey.currentState!.save(); //เป็นการสั่งให้ formKey ไปเรียกใช้งาน onSaved ทุกตัว
                                    
                                    FocusScope.of(context).unfocus(); // Close the keyboard
                                    
                                    //ทำการบันทึกช้อมูลลง collection จะบันทึกเหมือน json
                                    await _studentCollection.add({
                                      "fname": myStudent.fname,
                                      "lname": myStudent.lname,
                                      "nickname": myStudent.nickname,
                                      "email": myStudent.email,
                                      "score": myStudent.score,
                                      "room": myStudent.room
                                    });
                                    //clear แบบ form เพื่อให้ช่องเป็นค่าว่าง หลัง save
                                    formKey.currentState?.reset();
                                  }
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            );
          }
          //ถ้าไม่เจอ error ให้แสดงการโหลด
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
