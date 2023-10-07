import 'dart:math';
import 'package:flutter/material.dart';
import 'package:text_3d/text_3d.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ThreeDText(
          text: 'perspectiveRaised',
          textStyle: TextStyle(fontSize: 40, color: Colors.green),
          depth: 10,
          style: ThreeDStyle.perspectiveRaised,
          angle: pi / 6,
          perspectiveDepth: 30,
        ),
          ThreeDText(
            text: 'perspectiveInset',
            textStyle: TextStyle(fontSize: 40, color: Colors.purpleAccent),
            depth: 40,
            style: ThreeDStyle.perspectiveInset,
            angle: pi / 6,
            perspectiveDepth: 20,
          ),
          ThreeDText(
            text: 'perspectiveRight',
            textStyle: TextStyle(fontSize: 25, color: Colors.yellow),
            style: ThreeDStyle.perspectiveLeft,
            perspectiveDepth: 45.0,
          ),
          ThreeDText(
            text: 'perspectiveLeft',
            textStyle: const TextStyle(
                fontSize: 25,
                color: Colors.pink ,
                fontWeight: FontWeight.bold),
            depth: 6,
            style: ThreeDStyle.perspectiveLeft,
            perspectiveDepth: -45.0,
          ),
          ThreeDText(
            text: "inset",
            textStyle: TextStyle(
              fontSize: 64,
              color: Colors.pinkAccent,
            ),
            style: ThreeDStyle.inset,
          ),
          ThreeDText(
            text: 'raised',
            textStyle: TextStyle(fontSize: 64, color: Colors.blue),
            depth: 10,
            style: ThreeDStyle
                .raised,
          ),
          ThreeDText(
            text: 'standard',
            textStyle: TextStyle(fontSize: 40, color: Colors.blue),
            depth: 5,
            style: ThreeDStyle
                .standard,
          ),
          ThreeDText(
            text: 'inset with angle',
            textStyle: TextStyle(fontSize: 40, color: Colors.deepOrange),
            depth: 5,
            style: ThreeDStyle.inset,
            angle: 70,
            // 30 degrees
          ),

        ],
      )),
    );
  }
}
