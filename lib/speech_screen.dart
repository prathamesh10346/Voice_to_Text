import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voicetospeek/chat_model.dart';
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
          duration: const Duration(milliseconds: 2000),
          glowColor: const Color.fromARGB(255, 202, 32, 114),
          repeatPauseDuration: const Duration(milliseconds: 100),
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
              backgroundColor: const Color.fromARGB(255, 118, 196, 165),
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
              const Gap(10),
              const Text('Voice Assistant',
                  style: TextStyle(
                    color: Color(0xFFEDEDED),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          // centerTitle: true,
          backgroundColor: const Color.fromARGB(0, 138, 134, 134),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            margin: const EdgeInsets.only(bottom: 150),
            color: const Color.fromARGB(4, 224, 71, 191),
            child: Column(
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: listing
                        ? const Color.fromARGB(255, 229, 225, 225)
                        : const Color.fromARGB(255, 165, 162, 162),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return chatBubble(
                          chattext: "Hello how are you Pt?",
                          type: chatMessagetype.user);
                    },
                  ),
                )),
                Text(
                  "Developed by Prathmesh",
                  style: TextStyle(
                    color: listing
                        ? const Color.fromARGB(255, 229, 225, 225)
                        : const Color.fromARGB(255, 165, 162, 162),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget chatBubble({required chattext, required chatMessagetype type}) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 34, 15, 81),
          child: Icon(
            Icons.person,
            color: Color.fromARGB(255, 197, 200, 198),
          ),
        ),
        const Gap(12),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: Color.fromARGB(163, 97, 164, 97),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
            ),
            child: Text("$chattext",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ),
        ),
      ],
    );
  }
}
