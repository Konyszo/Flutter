import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage()
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text('Profil'),
        actions: [
          IconButton(onPressed: () {print('Ustawienia');}, icon: Icon(Icons.settings))
        ]
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(

          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tu będzie profil'),
            ],
          ),
        ),
      ),
    );
  }
}
