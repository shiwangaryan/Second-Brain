import 'dart:async';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/features/chatbot/model/chat_message.dart';
import 'package:google_gemini/google_gemini.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> messages = [];
  TextEditingController textEditingController = TextEditingController();
  StreamSubscription? subscription;
  final gemini =
      GoogleGemini(apiKey: 'AIzaSyCnlDOOB8f3bx4szZEBe3ZcGHo1TTpFxdg');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void sendMessageFunction() async {
    ChatMessage message =
        ChatMessage(sender: 'user', message: textEditingController.text);

    setState(() {
      messages.insert(0, message);
    });
    textEditingController.clear();

    try {
      final response = await gemini.generateFromText(message.message);
      setState(() {
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              controller: textEditingController,
              onSubmitted: (value) => sendMessageFunction(),
              decoration: InputDecoration(
                  hintText: 'Talk to us',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  )),
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
    final double screenHeight = MediaQuery.of(context).size.height;

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
        appBar: const CustomAppBar(),
        body: Column(
          children: [
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
              child: SendMessage(),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 95,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Padding(
        padding: EdgeInsets.only(top: 35.0, bottom: 20),
        child: Text(
          'Serenity',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 35,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(95);
}
