import 'package:flutter/material.dart';
import 'speech_to_text_page.dart';
import 'text_to_speech_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ML TTS & STT App'),
        backgroundColor: Colors.teal[700],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 248, 248, 248), const Color.fromARGB(255, 77, 182, 172)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // App logo or icon
              Container(
                margin: EdgeInsets.only(bottom: 40),
                child: Icon(
                  Icons.speaker,
                  size: 100,
                  color: Colors.teal[800],
                ),
              ),
              // Text-to-Speech Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TextToSpeechPage()),
                  );
                },
                child: Text(
                  'Text to Speech',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.teal[600], // Text color
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Speech-to-Text Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SpeechToTextPage()),
                  );
                },
                child: Text(
                  'Speech to Text',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.teal[600], // Text color
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
