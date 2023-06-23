import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/ListTileRoster.dart';
import 'package:flutter_firebase/screen/scoreScreen.dart';
import 'package:flutter_firebase/screen/formscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/screen/studentRoster.dart';
import 'firebase_options.dart';

// void main() async {
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: [
              FormScreen(), //เอา widget ที่จะแสดงหน้าจอมา teb แรกก็จะไปจับคู่กับ widget นี้
              ScoreScreen(),
              StudentRoster()
            ],
          ),
          backgroundColor: Colors.indigo[700],
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(text: 'บันทึกช้อมูล'),
              Tab(text: 'รายงานคะแนน'),
              Tab(text: 'รายชื่อนักเรียน',)
            ]
          ),
        ));
  }
}
