import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_ahtu/screens/dispo.dart';
import 'dart:math';
import 'package:flutter/scheduler.dart';

class Snowflake {
  double x;
  double y;
  double size;
  double speed;

  Snowflake(this.x, this.y, this.size, this.speed);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final List<Snowflake> snowflakes = [];
  final Random random = Random();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(minutes: 1),
      vsync: this,
    )..repeat();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      for (int i = 0; i < 50; i++) {
        snowflakes.add(Snowflake(
          random.nextDouble() * MediaQuery.of(context).size.width,
          -random.nextDouble() * MediaQuery.of(context).size.height,
          random.nextDouble() * 5 + 2,
          random.nextDouble() * 0.2 + 1,
        ));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(160),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/res.png",
                      scale: 0.8,
                      height: 260,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.666,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.666,
                padding: EdgeInsets.only(top: 40, bottom: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                    )),
                child: Column(
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Bienvenue dans Resalle',
                          textStyle: GoogleFonts.ubuntu(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            wordSpacing: 2,
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 100,
                      pause: const Duration(milliseconds: 500),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),

                    SizedBox(height: 15,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "Resalle est une application du OCP Group pour la réservation de la salle des réunions",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisponibleScreen(
                              startTime: DateTime(2023, 8, 30, 12, 0),
                              currentTime: DateTime.now(),
                            ),
                          ),
                        );


                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        primary: Colors.green.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Commencer',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                              letterSpacing: 1
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Snowfall animation
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                for (final snowflake in snowflakes) {
                  snowflake.y += snowflake.speed;
                  if (snowflake.y > MediaQuery.of(context).size.height) {
                    snowflake.y = -snowflake.size;
                    snowflake.x = random.nextDouble() * MediaQuery.of(context).size.width;
                  }
                }
                return Stack(
                  children: [
                    for (final snowflake in snowflakes)
                      Positioned(
                        left: snowflake.x,
                        top: snowflake.y,
                        child: Container(
                          width: snowflake.size,
                          height: snowflake.size,
                          decoration: BoxDecoration(
                            color: Colors.green.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

