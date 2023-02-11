import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:voicetospeek/app_layout.dart';
import 'package:voicetospeek/speech_screen.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  late RiveAnimationController _controller;
  @override
  // final size = Applayout.getSize(context);

  void initState() {
    _controller = OneShotAnimation("active", autoplay: false);

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 8, 54),
      body: Stack(
        children: [
          const RiveAnimation.asset(
            'assets/images/new_file.riv',
          ),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 110, sigmaY: 110),
            child: const SizedBox(),
          )),
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gap Applayout.getHeight(100),
              Gap(Applayout.getHeight(50)),
              Container(
                height: Applayout.getHeight(500),
                width: Applayout.getWidth(400),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/img1.png"),
                  ),
                ),
              ),
              // Gap(size.height * 0.001),
              Container(
                height: Applayout.getHeight(50),
                width: Applayout.getWidth(400),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/img2.png"),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "Talk into ",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Text",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "  Convert your speech into perfect text.\n with AI voice library and customizations ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 159, 159, 159),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.isActive = true;
                  });
                },
                child: animation_btn(controller: _controller),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}

// class SplachScreen extends StatelessWidget {
//   const SplachScreen({super.key});

//   @override

//   Widget build(BuildContext context) {late RiveAnimationController _controller;
//     final size = Applayout.getSize(context);
//     void initState() {
//       _controller = OneShotAnimation("active", autoplay: false);

//       super.initState();
//     }

//     return
//   }
// }

class animation_btn extends StatelessWidget {
  const animation_btn({
    Key? key,
    required RiveAnimationController controller,
  })  : _controller = controller,
        super(key: key);

  final RiveAnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: 260,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              _controller.isActive = true;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SpeechScreen()),
              );
            },
            child: RiveAnimation.asset(
              'assets/images/button.riv',
              controllers: [_controller],
            ),
          ),
          Positioned.fill(
            top: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 25,
                ),
                Gap(10),
                Text("Let`s See",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        height: 1.2,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
