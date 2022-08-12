import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final TextEditingController _hisname = TextEditingController();
  final TextEditingController _hername = TextEditingController();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.repeat();

    super.initState();
  }

  void reset() {
    setState(() {
      _hisname.text = "";
      _hername.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _animationController.value * 100;
    void press() {
      final text1 = _hisname.text;
      final text2 = _hername.text;

      if (text1 != "" && text2 != "") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: LiquidCustomProgressIndicator(
                          direction: Axis.vertical,
                          shapePath: _buildHeartPath(),
                          center: Text(
                            '${percentage.toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          valueColor: const AlwaysStoppedAnimation(Colors.red),
                          value: _animationController.value,
                          backgroundColor: Colors.pinkAccent),
                    ),
                    const SizedBox(height: 25),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Text('$text1 💖 $text2'),
                    ),
                  ],
                ),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text('İsim giriniz!'),
              );
            });
      }
      reset();
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Image.network(
              "https://images.unsplash.com/photo-1527628173875-3c7bfd28ad78?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 250),
                  child: Image.asset(
                    "assets/shape.png",
                    height: 75,
                    width: 75,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 2),
                  ),
                  child: TextField(
                    controller: _hisname,
                    decoration: const InputDecoration(
                      // ignore: deprecated_member_use
                      prefixIcon: Icon(FontAwesomeIcons.male),
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                      ),
                      hintText: "Man",
                      contentPadding: EdgeInsets.only(left: 20, top: 12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 2),
                  ),
                  child: TextField(
                    controller: _hername,
                    decoration: const InputDecoration(
                      // ignore: deprecated_member_use
                      prefixIcon: Icon(FontAwesomeIcons.female),
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                      ),
                      hintText: "Woman",
                      contentPadding: EdgeInsets.only(left: 20, top: 12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 250),
                  child: Image.asset(
                    "assets/sh.png",
                    height: 75,
                    width: 75,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                InkWell(
                  onTap: () => press(),
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.pink.shade900,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          width: 2, color: Colors.pinkAccent.shade100),
                    ),
                    child: const Text(
                      "Eros'a Sor!",
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Path _buildHeartPath() {
    return Path()
      ..moveTo(55, 15)
      ..cubicTo(55, 12, 50, 0, 30, 0)
      ..cubicTo(0, 0, 0, 37.5, 0, 37.5)
      ..cubicTo(0, 55, 20, 77, 55, 95)
      ..cubicTo(90, 77, 110, 55, 110, 37.5)
      ..cubicTo(110, 37.5, 110, 0, 80, 0)
      ..cubicTo(65, 0, 55, 12, 55, 15)
      ..close();
  }
}
