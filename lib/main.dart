import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AnimatedWidgetsTests(title: 'Animated Widgets Tests'),
    );
  }
}

class AnimatedWidgetsTests extends StatefulWidget {
  const AnimatedWidgetsTests({super.key, required this.title});
  final String title;

  @override
  State<AnimatedWidgetsTests> createState() => _AnimatedWidgetsTestsState();
}

class _AnimatedWidgetsTestsState extends State<AnimatedWidgetsTests>
    with TickerProviderStateMixin {
  final DecorationTween decorationTween = DecorationTween(
    begin: const BoxDecoration(
      shape: BoxShape.circle,
    ),
    end: const BoxDecoration(
        //color: Colors.lightBlue,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 0,
            spreadRadius: 15,
            color: Colors.lightBlueAccent,
            offset: Offset(0, 0),
          ),
          BoxShadow(
            blurRadius: 0,
            spreadRadius: 5,
            color: Colors.lightBlue,
            offset: Offset(0, 0),
          ),
        ]),
  );

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
    //reverseDuration: const Duration(milliseconds: 600),
  );

  bool isHolded = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var button = DecoratedBoxTransition(
        decoration: decorationTween.animate(_controller),
        position: DecorationPosition.background,
        child: SizedBox(
          width: 150,
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 120,
              height: 120,
              child: Material(
                elevation: 2,
                shape: CircleBorder(),
                color: Colors.blue,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  radius: 100,
                  onTapDown: (details) {
                    _controller.repeat(reverse: true);
                    setState(() {
                      isHolded = true;
                    });
                  },
                  onTapUp: (details) {
                    _controller.reset();
                    setState(() {
                      isHolded = false;
                    });
                  },
                  child: Center(
                    child: (isHolded)
                        ? const Icon(
                            Icons.pause_rounded,
                            size: 48,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.mic_none_outlined,
                            size: 48,
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
            ),
          ),
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: button),
    );
  }
}
