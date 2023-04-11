import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color? generatedColor;
  bool colors = true;
  String selectedRandomImg = '';
  List<String> randomBackgroundImages = [
    'https://docs.flutter.dev/assets/images/dash/early-dash-sketches2.jpg',
    'https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png',
    'https://docs.flutter.dev/assets/images/dash/early-dash-sketches3.jpg',
    'https://docs.flutter.dev/assets/images/dash/early-dash-sketches5.jpg',
    'https://docs.flutter.dev/assets/images/dash/dash-prototypes2.jpg',
  ];

  randomColor() {
    // Colors can be accessed by Color ( int value )
    // So I'll generate this int value from 0 to 0xFF FF FF FF
    // every 2 bytes indicates something
    // FF FF FF FF (alpha, red, green, blue)

    int nextValue = (Random().nextDouble() * 0xFFFFFFFF).toInt();

    // Here I'm just making sure that this is a new value
    // While it's still the same value I'll keep generating new values
    while (generatedColor?.value == nextValue) {
      nextValue = (Random().nextDouble() * 0xFFFFFFFF).toInt();
    }

    // When I finally have new value, set my background to it
    generatedColor = Color(nextValue);
    debugPrint('new background color');
  }

  randomImage() {
    int nextValue = Random().nextInt(randomBackgroundImages.length);

    while (selectedRandomImg == randomBackgroundImages[nextValue]) {
      nextValue = Random().nextInt(randomBackgroundImages.length);
    }

    // When I finally have new value, set my background to it
    selectedRandomImg = randomBackgroundImages[nextValue];
    debugPrint('new background image');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: InkWell(
        onTap: () {
          colors ? randomColor() : randomImage();
          setState(() {});
        },
        child: Container(
          height: screenHeight,
          width: screenWidth,
          color: colors ? generatedColor : null,
          decoration: colors
              ? null
              : selectedRandomImg.isNotEmpty
                  ? BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(selectedRandomImg),
                        fit: BoxFit.fill,
                      ),
                    )
                  : null,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Hey there',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color:
                            Color((Random().nextDouble() * 0xFFFFFFFF).toInt())
                                .withOpacity(1.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          colors = !colors;
          debugPrint(
              'toggled! ${colors ? 'changing colors' : 'changing images'} now');
          colors ? randomColor() : randomImage();
          setState(() {});
        },
        tooltip: 'Toggle',
        backgroundColor: generatedColor,
        elevation: 10,
        child: Icon(
          Icons.ac_unit,
          color: Color((Random().nextDouble() * 0xFFFFFFFF).toInt())
              .withOpacity(1.0),
        ),
      ),
    );
  }
}
