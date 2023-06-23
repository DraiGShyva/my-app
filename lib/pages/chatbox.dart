import 'package:app/models/drawer/list_page.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map<String, dynamic>> messages = [];
  final textController = TextEditingController();

  final openAI = OpenAI.instance.build(
      token: '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',
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true);

  void sendMessage(text) async {
    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": text})
    ], maxToken: 200, model: ChatModel.gptTurbo);

    final response = await openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      setState(() {
        messages.add({
          'text': element.message?.content,
          'isUserMessage': false,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const Icon(
              Icons.account_box_outlined,
              size: 150,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: const ListPageDrawer()),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final bool isUserMessage = message['isUserMessage'];
                final String text = message['text'];

                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: isUserMessage ? Colors.white : Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 94, 147, 255),
                      offset: Offset(1.5, 2.5))
                ]),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final text = textController.text;
                    if (text.isNotEmpty) {
                      setState(() {
                        messages.add({
                          'text': text,
                          'isUserMessage': true,
                        });
                        sendMessage(text);
                      });
                      textController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
