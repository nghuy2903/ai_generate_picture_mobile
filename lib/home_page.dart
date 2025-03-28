import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_recognition_result.dart' show SpeechRecognitionResult;
import 'package:speech_to_text/speech_to_text.dart';
import 'message.dart';
import 'pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _Homepage();
}

class _Homepage extends State<HomePage> {
  final speechToText = SpeechToText();
  String lastWords = '';
  late GenerativeModel _model;
  late ChatSession _chatSession;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadApiKey();
  }

  Future<void> _loadApiKey() async {
    try {
    // Đọc file env.json từ assets
    final String jsonString = await rootBundle.loadString('assets/env.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    // Lấy API key từ file JSON
    String apiKey = jsonData['api_key']?.toString() ?? '';

    // Kiểm tra API Key hợp lệ
    if (apiKey.isNotEmpty) {
      setState(() {
        _model = GenerativeModel(
          model: 'gemini-1.5-flash', // Kiểm tra model hợp lệ
          apiKey: apiKey,
        );
        _chatSession = _model.startChat();
      });
    } else {
      print("⚠ API Key không hợp lệ hoặc rỗng");
      }
    } catch (e) {
      print("❌ Lỗi khi đọc API Key: $e");
    }

  }

  @override
  void dispose() {
    speechToText.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aglie"),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _chatSession.history.length,
                itemBuilder: (context, index) {
                  final Content content = _chatSession.history.toList()[index];
                  final text = content.parts
                      .whereType<TextPart>()
                      .map<String>((e) => e.text)
                      .join('');
                  return Message(
                    text: text,
                    isFromUser: content.role == 'user',
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: textFieldDecoration(),
                      controller: _textController,
                      onSubmitted: _sendChatMessage,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: () {
                      
                      if (_textController.text.trim().isNotEmpty) {
                        _sendChatMessage(_textController.text.trim());
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration textFieldDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(15),
      hintText: 'Enter a prompt...',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    final response = await _chatSession.sendMessage(Content.text(message));
    final text = response.text;

    setState(() {
      _loading = false;
      _textController.clear();
      _scrollDown();
    });
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeOutCirc,
      ),
    );
  }
}