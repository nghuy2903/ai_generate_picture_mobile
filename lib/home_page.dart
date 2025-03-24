import 'package:ai_generate_picture/feature_box.dart';
import 'package:ai_generate_picture/pallete.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _Homepage();

}

class _Homepage extends State<HomePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aglie"),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //Virtual Assistants
          Stack(
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: const BoxDecoration(
                    color: Pallete.assistantCircleColor,
                    shape: BoxShape.circle
                  ),
                ),
              ),
              Container(
                height: 123,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage("assets/images/virtualAssistant.png"))
                ),
              )
            ],
          ),

          //chat bubble
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30).copyWith(
              top: 30,

            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Pallete.borderColor
              ),
              borderRadius: BorderRadius.circular(20).copyWith(
                topLeft: Radius.zero,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: const Text('Hi! What task can I do for you?', 
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.mainFontColor,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(
              top: 10,
              left: 22,
            ),
            child: const Text('Here are a few features', style: TextStyle(
              fontFamily: 'Cera Pro',
              color: Pallete.mainFontColor,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
          ),
          //Features List
          Column(
            children: [
              FeatureBox(
                color: Pallete.firstSuggestionBoxColor,
                headerText: 'Chat GPT',
                descriptionText: 'Way for success',
              ),
            ],
          )
        ],
      ),
    );
  }
}
