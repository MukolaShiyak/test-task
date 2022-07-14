import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Test task - Mykola Shiyak'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _color = const Color(0xffffffff);
  late final double _screenDiagonale;
  final String _text = 'Hey there';
  final TextStyle _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _screenDiagonale = math.sqrt(
          math.pow(MediaQuery.of(context).size.width, 2) +
              math.pow(MediaQuery.of(context).size.height, 2));
    });
    super.initState();
  }

  void _calculateDiagonale(Offset offset) {
    var selectedDiagonale =
        math.sqrt(math.pow(offset.dx, 2) + math.pow(offset.dy, 2));

    _color =
        Color(((0xffffffff / _screenDiagonale) * selectedDiagonale).toInt());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTapUp: (TapUpDetails details) =>
            _calculateDiagonale(details.localPosition),
        child: Scaffold(
          backgroundColor: _color,
          appBar: AppBar(
            title: Text(widget.title),
            centerTitle: true,
          ),
          body: Center(
            child: SizedBox(
              child: Stack(
                children: [
                  Text(
                    _text,
                    style: _textStyle.copyWith(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 3
                        ..color = Colors.white,
                    ),
                  ),
                  Text(
                    _text,
                    style: _textStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
