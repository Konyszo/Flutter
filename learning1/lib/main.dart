import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Moja aplikacja'),
        ),
        body: HomePage(),
      ),
    );
  }
}

class LifecycleBox extends StatefulWidget {
  const LifecycleBox({super.key});

  @override
  State<LifecycleBox> createState() => _LifecycleBoxState();
}

class _LifecycleBoxState extends State<LifecycleBox> {
  int count = 0;

  @override
  void initState() {
    print('initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Column(
      children: [
        Text('Count: $count'),
        ElevatedButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: Text('+')
        )
      ],
    );
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showBox = true;

  String buttonName(bool value) {
    String name = value ? 'hide' : 'show';
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(
              () {
                showBox = !showBox;
              }
            );
          }, 
          child: Text(buttonName(showBox))
        ),
        if (showBox) const LifecycleBox(),
      ],
    );
  }
}