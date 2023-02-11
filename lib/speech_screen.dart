import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voicetospeek/color.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speech = SpeechToText();
  var text = "Hold the button and start speeking";
  var listing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 4, 8, 54),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          endRadius: 75.0,
          animate: listing,
          duration: Duration(milliseconds: 2000),
          glowColor: Color.fromARGB(255, 202, 32, 114),
          repeatPauseDuration: Duration(milliseconds: 100),
          repeat: true,
          showTwoGlows: true,
          child: GestureDetector(
            onTapDown: (details) async {
              if (!listing) {
                var available = await speech.initialize();
                if (available) {
                  setState(() {
                    listing = true;
                    speech.listen(
                      onResult: (result) {
                        setState(() {
                          text = result.recognizedWords;
                        });
                      },
                    );
                  });
                }
              }
            },
            onTapUp: (details) {
              setState(() {
                listing = false;
              });
              speech.stop();
            },
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 118, 196, 165),
              radius: 35,
              child: Icon(
                listing ? Icons.mic : Icons.mic_none,
                color: Colors.white,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.sort,
                color: Color.fromARGB(255, 247, 247, 247)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            children: [
              const Icon(
                Icons.mic,
                size: 30,
                color: Color.fromARGB(255, 212, 55, 149),
              ),
              Gap(10),
              const Text('Speech to text',
                  style: TextStyle(
                    color: Color(0xFFEDEDED),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          // centerTitle: true,
          backgroundColor: Color.fromARGB(0, 138, 134, 134),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          reverse: true,
          physics: BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            margin: EdgeInsets.only(bottom: 150),
            color: Color.fromARGB(4, 224, 71, 191),
            child: Text(
              text,
              style: TextStyle(
                color: listing
                    ? Color.fromARGB(255, 229, 225, 225)
                    : Color.fromARGB(255, 165, 162, 162),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ));
  }
}
