import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_app/features/chatbot/model/chat_message.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:solution_challenge_app/keys.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> messages = [];
  final gemini =
      GoogleGemini(apiKey: geminiAPI);
  TextEditingController textEditingController = TextEditingController();
  StreamSubscription? subscription;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  Widget loadingIndicator() {
    return const SpinKitPulse(color: Colors.white, size: 30);
  }

  void sendMessageFunction() async {
    ChatMessage message =
        ChatMessage(sender: 'user', message: textEditingController.text);

    setState(() {
      messages.insert(0, message);
      loading = true;
    });
    textEditingController.clear();

    try {
      final response = await gemini.generateFromText(message.message);
      setState(() {
        loading = false;
        messages.insert(
          0,
          ChatMessage(sender: 'Serenity', message: response.text),
        );
      });
    } catch (error) {
      print('Error generating response $error');
    }
  }

  Widget SendMessage() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              controller: textEditingController,
              onSubmitted: (value) => sendMessageFunction(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8),
                hintText: 'Talk to us',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => sendMessageFunction(),
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 53, 192, 199),
            Color(0XFF1A84B8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const ChatScreenAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            const SizedBox(
              width: 325,
              height: 41,
              child: Text(
                "Hey I'm Serenity, a chatbot here for helping you, feel free to ask me anything!",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Flexible(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: messages[index],
                  );
                },
              ),
            ),
            loading == true
                ? SizedBox(child: loadingIndicator())
                : const SizedBox(height: 0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
              child: SendMessage(),
            ),
          ],
        ),
      ),
    );
  }
}

//-----------
//app bar
//-----------
class ChatScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 95,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          color: Colors.white,
        ),
      ),
      title: const Padding(
        padding: EdgeInsets.only(top: 35.0, bottom: 20),
        child: Text(
          'Serenity',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(95);
}
