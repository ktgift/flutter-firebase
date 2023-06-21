import 'package:flutter/material.dart';
import 'package:flutter_firebase/screen/formscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              FormScreen(), //เอา widget ที่จะแสดงหน้าจอมา teb แรกก็จะไปจับคู่กับ widget นี้
              Container()
            ],
          ),
          backgroundColor: Colors.grey,
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(text: 'Exam Scores Tracke'),
              Tab(text: 'Student Roster',)
            ]
          ),
        ));
  }
}
